#include "libobjecttracker/object_tracker.h"

// PCL
#include <pcl/point_cloud.h>
#include <pcl/point_types.h>
#include <pcl/common/transforms.h>
#include <pcl/registration/icp.h>
#include <pcl/registration/transformation_estimation_2D.h>
// #include <pcl/registration/transformation_estimation_lm.h>
#include <pcl/search/impl/search.hpp>

#include "assignment.hpp"

// TEMP for debug
#include <cstdio>

using Point = pcl::PointXYZ;
using Cloud = pcl::PointCloud<Point>;
using ICP = pcl::IterativeClosestPoint<Point, Point>;

static Eigen::Vector3f pcl2eig(Point p)
{
  return Eigen::Vector3f(p.x, p.y, p.z);
}

static Point eig2pcl(Eigen::Vector3f v)
{
  return Point(v.x(), v.y(), v.z());
}

static float deltaAngle(float a, float b)
{
  return atan2(sin(a-b), cos(a-b));
}

namespace libobjecttracker {

/////////////////////////////////////////////////////////////

Object::Object(
  size_t markerConfigurationIdx,
  size_t dynamicsConfigurationIdx,
  const Eigen::Affine3f& initialTransformation,
  const std::string& name)
  : m_markerConfigurationIdx(markerConfigurationIdx)
  , m_dynamicsConfigurationIdx(dynamicsConfigurationIdx)
  , m_lastTransformation(initialTransformation)
  , m_initialTransformation(initialTransformation)
  , m_lastValidTransform()
  , m_lastTransformationValid(false)
  , m_name(name)
{
}

const Eigen::Affine3f& Object::transformation() const
{
  return m_lastTransformation;
}

const Eigen::Affine3f& Object::initialTransformation() const
{
  return m_initialTransformation;
}

bool Object::lastTransformationValid() const
{
  return m_lastTransformationValid;
}

/////////////////////////////////////////////////////////////

ObjectTracker::ObjectTracker(
  const std::vector<DynamicsConfiguration>& dynamicsConfigurations,
  const std::vector<MarkerConfiguration>& markerConfigurations,
  const std::vector<Object>& objects)
  : m_markerConfigurations(markerConfigurations)
  , m_dynamicsConfigurations(dynamicsConfigurations)
  , m_objects(objects)
  , m_trackPositionOnly(false)
  , m_initialized(false)
  , m_init_attempts(0)
  , m_logWarn()
{
  // if at least one of the used marker configurations only has one marker,
  // then switch to position only tracking

  for (const Object& object : m_objects) {
    Cloud::Ptr &objMarkers = m_markerConfigurations[object.m_markerConfigurationIdx];
    size_t const objNpts = objMarkers->size();
    if (objNpts == 1) {
      m_trackPositionOnly = true;
      break;
    }
  }
}

void ObjectTracker::update(Cloud::Ptr pointCloud)
{
  update(std::chrono::high_resolution_clock::now(), pointCloud);
}

void ObjectTracker::update(std::chrono::high_resolution_clock::time_point time,
  Cloud::Ptr pointCloud)
{
  if (m_trackPositionOnly) {
    updatePosition(time, pointCloud);
  } else {
    updatePose(time, pointCloud);
  }
}

const std::vector<Object>& ObjectTracker::objects() const
{
  return m_objects;
}

void ObjectTracker::setLogWarningCallback(
  std::function<void(const std::string&)> logWarn)
{
  m_logWarn = logWarn;
}

bool ObjectTracker::initializePose(Cloud::ConstPtr markersConst)
{
  if (markersConst->size() == 0) {
    return false;
  }

  // we need to mutate the cloud by deleting points
  // once they are assigned to an object
  Cloud::Ptr markers(new Cloud(*markersConst));

  size_t const nObjs = m_objects.size();

  ICP icp;
  icp.setMaximumIterations(5);
  icp.setInputTarget(markers);

  // prepare for knn query
  std::vector<int> nearestIdx;
  std::vector<float> nearestSqrDist;
  std::vector<int> objTakePts;
  pcl::KdTreeFLANN<Point> kdtree;
  kdtree.setInputCloud(markers);

  // compute the distance between the closest 2 objects in the nominal configuration
  // we will use this value to limit allowed deviation from nominal positions
  float closest = FLT_MAX;
  for (int i = 0; i < nObjs; ++i) {
    auto pi = m_objects[i].initialCenter();
    for (int j = i + 1; j < nObjs; ++j) {
      float dist = (pi - m_objects[j].initialCenter()).norm();
      closest = std::min(closest, dist);
    }
  }
  float const max_deviation = closest / 3;

  //printf("Object tracker: limiting distance from nominal position "
  //  "to %f meters\n", max_deviation);

  bool allFitsGood = true;
  for (int iObj = 0; iObj < nObjs; ++iObj) {
    Object& object = m_objects[iObj];
    Cloud::Ptr &objMarkers =
      m_markerConfigurations[object.m_markerConfigurationIdx];
    icp.setInputSource(objMarkers);

    // find the points nearest to the object's nominal position
    // (initial pos was loaded into lastTransformation from config file)
    size_t const objNpts = objMarkers->size();
    nearestIdx.resize(objNpts);
    nearestSqrDist.resize(objNpts);
    auto nominalCenter = eig2pcl(object.initialCenter());
    int nFound = kdtree.nearestKSearch(
      nominalCenter, objNpts, nearestIdx, nearestSqrDist);

    if (nFound < objNpts) {
      std::stringstream sstr;
      sstr << "error: only " << nFound
           << " neighbors found for object " << object.name()
           << " (need " << objNpts << ")";
      logWarn(sstr.str());
      allFitsGood = false;
      continue;
    }

    // only try to fit the object if the k nearest neighbors
    // are reasonably close to the nominal object position
    Eigen::Vector3f actualCenter(0, 0, 0);
    for (int i = 0; i < objNpts; ++i) {
      actualCenter += pcl2eig((*markers)[nearestIdx[i]]);
    }
    actualCenter /= objNpts;
    if ((actualCenter - pcl2eig(nominalCenter)).norm() > max_deviation) {
      std::stringstream sstr;
      sstr << "error: nearest neighbors of object " << object.name()
           << " are centered at " << actualCenter
           << " instead of " << nominalCenter;
      logWarn(sstr.str());
      allFitsGood = false;
      continue;
    }

    // try ICP with guesses of many different yaws about knn centroid
    Cloud result;
    static int const N_YAW = 20;
    double bestErr = DBL_MAX;
    Eigen::Affine3f bestTransformation;
    for (int i = 0; i < N_YAW; ++i) {
      float yaw = i * (2 * M_PI / N_YAW);
      Eigen::Matrix4f tryMatrix = pcl::getTransformation(
        actualCenter.x(), actualCenter.y(), actualCenter.z(),
        0, 0, yaw).matrix();
      icp.align(result, tryMatrix);
      if (icp.hasConverged()) {
        double err = icp.getFitnessScore();
        if (err < bestErr) {
          bestErr = err;
          bestTransformation = icp.getFinalTransformation();
        }
      }
    }

    const DynamicsConfiguration& dynConf = m_dynamicsConfigurations[object.m_dynamicsConfigurationIdx];
    if (bestErr >= dynConf.maxFitnessScore) {
      std::stringstream sstr;
      sstr << "Initialize did not succeed (fitness too low) "
           << " for object " << object.name();
      logWarn(sstr.str());
      allFitsGood = false;
      continue;
    }

    // if the fit was good, this object "takes" the markers, and they become
    // unavailable to all other objects so we don't double-assign markers
    // (TODO: this is so greedy... do we need a more global approach?)
    object.m_lastTransformation = bestTransformation;
    // remove highest indices first
    std::sort(objTakePts.rbegin(), objTakePts.rend());
    for (int idx : objTakePts) {
      markers->erase(markers->begin() + idx);
    }
    // update search structures after deleting markers
    icp.setInputTarget(markers);
    kdtree.setInputCloud(markers);
  }

  ++m_init_attempts;
  return allFitsGood;
}

void ObjectTracker::updatePose(std::chrono::high_resolution_clock::time_point stamp,
  Cloud::ConstPtr markers)
{
  if (markers->empty()) {
    for (auto& object : m_objects) {
      object.m_lastTransformationValid = false;
    }
    return;
  }

  m_initialized = m_initialized || initializePose(markers);
  if (!m_initialized) {
    logWarn(
      "Object tracker initialization failed - "
      "check that position is correct, all markers are visible, "
      "and marker configuration matches config file");
    // Doesn't make too much sense to continue here - lets wait to be fully initialized
    return;
  }

  ICP icp;
  // pcl::registration::TransformationEstimationLM<Point, Point>::Ptr trans(new pcl::registration::TransformationEstimationLM<Point, Point>);
  // pcl::registration::TransformationEstimation2D<Point, Point>::Ptr trans(new pcl::registration::TransformationEstimation2D<Point, Point>);
  // pcl::registration::TransformationEstimation3DYaw<Point, Point>::Ptr trans(new pcl::registration::TransformationEstimation3DYaw<Point, Point>);
  // icp.setTransformationEstimation(trans);


  // // Set the maximum number of iterations (criterion 1)
  icp.setMaximumIterations(5);
  // // Set the transformation epsilon (criterion 2)
  // icp.setTransformationEpsilon(1e-8);
  // // Set the euclidean distance difference epsilon (criterion 3)
  // icp.setEuclideanFitnessEpsilon(1);

  icp.setInputTarget(markers);

  for (auto& object : m_objects) {
    object.m_lastTransformationValid = false;

    std::chrono::duration<double> elapsedSeconds = stamp-object.m_lastValidTransform;
    double dt = elapsedSeconds.count();

    // Set the max correspondence distance
    // TODO: take max here?
    const DynamicsConfiguration& dynConf = m_dynamicsConfigurations[object.m_dynamicsConfigurationIdx];
    float maxV = dynConf.maxXVelocity;
    icp.setMaxCorrespondenceDistance(maxV * dt);
    // ROS_INFO("max: %f", maxV * dt);

    // Update input source
    icp.setInputSource(m_markerConfigurations[object.m_markerConfigurationIdx]);

    // Perform the alignment
    Cloud result;
    // auto deltaPos = Eigen::Translation3f(dt * object.m_velocity);
    // auto predictTransform = deltaPos * object.m_lastTransformation;
    auto predictTransform = object.m_lastTransformation;
    icp.align(result, predictTransform.matrix());
    if (!icp.hasConverged()) {
      // ros::Time t = ros::Time::now();
      // ROS_INFO("ICP did not converge %d.%d", t.sec, t.nsec);
      std::stringstream sstr;
      sstr << "ICP did not converge!"
           << " for object " << object.name();
      logWarn(sstr.str());
      continue;
    }

    // Obtain the transformation that aligned cloud_source to cloud_source_registered
    Eigen::Matrix4f transformation = icp.getFinalTransformation();

    Eigen::Affine3f tROTA(transformation);
    float x, y, z, roll, pitch, yaw;
    pcl::getTranslationAndEulerAngles(tROTA, x, y, z, roll, pitch, yaw);

    // Compute changes:
    float last_x, last_y, last_z, last_roll, last_pitch, last_yaw;
    pcl::getTranslationAndEulerAngles(object.m_lastTransformation, last_x, last_y, last_z, last_roll, last_pitch, last_yaw);

    float vx = (x - last_x) / dt;
    float vy = (y - last_y) / dt;
    float vz = (z - last_z) / dt;
    float wroll = deltaAngle(roll, last_roll) / dt;
    float wpitch = deltaAngle(pitch, last_pitch) / dt;
    float wyaw = deltaAngle(yaw, last_yaw) / dt;

    // ROS_INFO("v: %f,%f,%f, w: %f,%f,%f, dt: %f", vx, vy, vz, wroll, wpitch, wyaw, dt);

    if (   fabs(vx) < dynConf.maxXVelocity
        && fabs(vy) < dynConf.maxYVelocity
        && fabs(vz) < dynConf.maxZVelocity
        && fabs(wroll) < dynConf.maxRollRate
        && fabs(wpitch) < dynConf.maxPitchRate
        && fabs(wyaw) < dynConf.maxYawRate
        && fabs(roll) < dynConf.maxRoll
        && fabs(pitch) < dynConf.maxPitch
        && icp.getFitnessScore() < dynConf.maxFitnessScore)
    {
      object.m_velocity = (tROTA.translation() - object.center()) / dt;
      object.m_lastTransformation = tROTA;
      object.m_lastValidTransform = stamp;
      object.m_lastTransformationValid = true;
    } else {
      std::stringstream sstr;
      sstr << "Dynamic check failed for object " << object.name() << std::endl;
      if (fabs(vx) >= dynConf.maxXVelocity) {
        sstr << "vx: " << vx << " >= " << dynConf.maxXVelocity << std::endl;
      }
      if (fabs(vy) >= dynConf.maxYVelocity) {
        sstr << "vy: " << vy << " >= " << dynConf.maxYVelocity << std::endl;
      }
      if (fabs(vz) >= dynConf.maxZVelocity) {
        sstr << "vz: " << vz << " >= " << dynConf.maxZVelocity << std::endl;
      }
      if (fabs(wroll) >= dynConf.maxRollRate) {
        sstr << "wroll: " << wroll << " >= " << dynConf.maxRollRate << std::endl;
      }
      if (fabs(wpitch) >= dynConf.maxPitchRate) {
        sstr << "wpitch: " << wpitch << " >= " << dynConf.maxPitchRate << std::endl;
      }
      if (fabs(wyaw) >= dynConf.maxYawRate) {
        sstr << "wyaw: " << wyaw << " >= " << dynConf.maxYawRate << std::endl;
      }
      if (fabs(roll) >= dynConf.maxRoll) {
        sstr << "roll: " << roll << " >= " << dynConf.maxRoll << std::endl;
      }
      if (fabs(pitch) >= dynConf.maxPitch) {
        sstr << "pitch: " << pitch << " >= " << dynConf.maxPitch << std::endl;
      }
      if (icp.getFitnessScore() >= dynConf.maxFitnessScore) {
        sstr << "fitness: " << icp.getFitnessScore() << " >= " << dynConf.maxFitnessScore << std::endl;
      }
      logWarn(sstr.str());
    }
  }

}

bool ObjectTracker::initializePosition(
  std::chrono::high_resolution_clock::time_point stamp,
  Cloud::ConstPtr markers)
{
  // Here, we use a simple task assignment to find the best initial matching
  libMultiRobotPlanning::Assignment<size_t, size_t> assignment;

  for (size_t i = 0; i < markers->size(); ++i) {
    Eigen::Vector3f marker = pcl2eig((*markers)[i]);
    for (size_t j = 0; j < m_objects.size(); ++j) {
      auto pi = m_objects[j].initialCenter();
      float dist = (pi - marker).norm();
      long cost = dist * 1000; // cost needs to be an integer -> convert to mm
      assignment.setCost(j, i, cost);
    }
  }

  std::map<size_t, size_t> solution; // maps objectId->markerId
  long totalCost = assignment.solve(solution);

  for (const auto& s : solution) {
    auto& object = m_objects[s.first];
    Eigen::Vector3f marker = pcl2eig((*markers)[s.second]);
    object.m_lastTransformation = Eigen::Translation3f(marker);
    object.m_lastValidTransform = stamp;
    object.m_lastTransformationValid = true;
  }

  return solution.size() == m_objects.size();
}

void ObjectTracker::updatePosition(std::chrono::high_resolution_clock::time_point stamp,
  Cloud::ConstPtr markers)
{
  static std::chrono::high_resolution_clock::time_point lastCall;
  std::chrono::duration<double> lastCallElapsedSeconds = stamp-lastCall;
  double lastCalldt = lastCallElapsedSeconds.count();
  lastCall = stamp;

  if (markers->empty()) {
    for (auto& object : m_objects) {
      object.m_lastTransformationValid = false;
    }
    return;
  }

  // re-initialize, if we have not received an update in a long time
  if (!m_initialized || lastCalldt > 0.4) {
    m_initialized = initializePosition(stamp, markers);
    if (!m_initialized) {
      logWarn(
        "Object tracker initialization failed - "
        "check that position is correct, all markers are visible, "
        "and marker configuration matches config file");
    }
    // Doesn't make too much sense to continue here - lets wait to be fully initialized
    return;
  }

  // In this case, we setup a task assignment problem, only considering markers that are in
  // close proximity to the previously known position. If we do not have a match for a
  // fixed amount of time, abandon that robot entirely (to avoid issues with spurios markers).
  libMultiRobotPlanning::Assignment<size_t, size_t> assignment; // objectIdx -> markerIdx

  // prepare for knn query
  std::vector<int> nearestIdx(5); // tune maximum number of neighbors here
  std::vector<float> nearestSqrDist(nearestIdx.size());
  pcl::KdTreeFLANN<Point> kdtree;
  kdtree.setInputCloud(markers);

  size_t const nObjs = m_objects.size();
  for (int iObj = 0; iObj < nObjs; ++iObj) {
    Object& object = m_objects[iObj];

    object.m_lastTransformationValid = false;

    std::chrono::duration<double> elapsedSeconds = stamp-object.m_lastValidTransform;
    double dt = elapsedSeconds.count();
    if (dt > 0.5) {
      std::stringstream sstr;
      sstr << "Lost tracking for object " << object.name() << " skipping";
      logWarn(sstr.str());
      continue;
    }

    auto nominalCenter = eig2pcl(object.center());
    int nFound = kdtree.nearestKSearch(
      nominalCenter, nearestIdx.size(), nearestIdx, nearestSqrDist);

    if (nFound < 1) {
      std::stringstream sstr;
      sstr << "error: no neighbors found for object " << object.name();
      logWarn(sstr.str());
      continue;
    }

    const DynamicsConfiguration& dynConf = m_dynamicsConfigurations[object.m_dynamicsConfigurationIdx];

    bool foundPotentialMarker = false;
    for (int iMarker = 0; iMarker < nFound; ++iMarker) {
      Eigen::Vector3f marker = pcl2eig((*markers)[nearestIdx[iMarker]]);

      // Compute changes:
      Eigen::Vector3f velocity = (marker - object.center()) / dt;
      float vx = velocity.x();
      float vy = velocity.y();
      float vz = velocity.z();

      if (   fabs(vx) < dynConf.maxXVelocity
          && fabs(vy) < dynConf.maxYVelocity
          && fabs(vz) < dynConf.maxZVelocity)
      {
        float dist = (marker - object.center()).norm();
        long cost = dist * 1000; // cost needs to be an integer -> convert to mm
        assignment.setCost(iObj, nearestIdx[iMarker], cost);
        foundPotentialMarker = true;
      }
    }
    if (!foundPotentialMarker) {
      std::stringstream sstr;
      sstr << "all dynamic check failed for object " << object.name() << std::endl;
      logWarn(sstr.str());
    }
  }

  std::map<size_t, size_t> solution; // maps objectId->markerId
  long totalCost = assignment.solve(solution);

  for (const auto& s : solution) {
    auto& object = m_objects[s.first];
    Eigen::Vector3f marker = pcl2eig((*markers)[s.second]);
    std::chrono::duration<double> elapsedSeconds = stamp-object.m_lastValidTransform;
    double dt = elapsedSeconds.count();

    object.m_velocity = (marker - object.center()) / dt;
    object.m_lastTransformation = Eigen::Translation3f(marker);
    object.m_lastValidTransform = stamp;
    object.m_lastTransformationValid = true;
  }
}

void ObjectTracker::logWarn(const std::string& msg)
{
  if (m_logWarn) {
    m_logWarn(msg);
  }
}

} // namespace libobjecttracker

#ifdef STANDALONE
#include "stdio.h"
#include "cloudlog.hpp"
int main()
{
  libobjecttracker::ObjectTracker ot({}, {}, {});
  PointCloudLogger logger;
  PointCloudPlayer player;
  player.play(ot);
  puts("test OK");
}
#endif // STANDALONE
