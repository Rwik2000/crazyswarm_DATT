// ROS
//#include <ros/ros.h>
//#include <std_msgs/Float32.h>
//#include <sensor_msgs/PointCloud.h>
//#include <tf/transform_broadcaster.h>
//#include "vicon_ros/NamedPoseArray.h"

#include <random>

// PCL
#include <pcl/point_cloud.h>
#include <pcl/point_types.h>
#include <pcl/common/transforms.h>
#include <pcl/registration/icp.h>
#include <pcl/search/impl/search.hpp>

#ifdef USE_VICON_DIRECTLY
// VICON
#include "vicon_sdk/Client.h"
#endif

#define ENABLE_GROUND_TRUTH

struct DynamicsConfiguration
{
  double maxXVelocity;
  double maxYVelocity;
  double maxZVelocity;
  double maxPitchRate;
  double maxRollRate;
  double maxYawRate;
  double maxRoll;
  double maxPitch;
};

class Object
{
public:
  size_t markerConfigurationIdx;
  Eigen::Affine3f lastTransformation;
};

float offset[3] = {0.0, -0.01, -0.04};
float points[4][3] = {
  {0.0177184,0.0139654,0.0557585},
  {-0.0262914,0.0509139,0.0402475},
  {-0.0328889,-0.02757,0.0390601},
  {0.0431307,-0.0331216,0.0388839},
};

class ObjectTracker
{
public:
  ObjectTracker()
  {
    readMarkerConfigurations();
    readObjects();
  }

  typedef pcl::PointXYZ Point;
  typedef pcl::PointCloud<pcl::PointXYZ> Cloud;
  typedef pcl::IterativeClosestPoint<pcl::PointXYZ, pcl::PointXYZ> ICP;

  void run()
  {
    std::random_device r;
    std::default_random_engine eng(r());
    std::uniform_real_distribution<double> rng_trans(-0.004, 0.004);
    std::uniform_real_distribution<double> rng_rot(-0.02, 0.02);
    std::uniform_real_distribution<double> rng_jitter(-0.001, 0.001);

    for (int i = 0; i < 10000; ++i) {
      // randomize overall rotation
      m_objects[0].lastTransformation = pcl::getTransformation(
          rng_trans(eng), rng_trans(eng), rng_trans(eng),
          rng_rot(eng), rng_rot(eng), rng_rot(eng));
      // perturb points
      Cloud &orig = *m_markerConfigurations[0];
      Cloud &perturbed = *m_markerConfigurations[1];
      for (int i = 0; i < 4; ++i) {
        perturbed[i].x = orig[i].x + rng_jitter(eng);
        perturbed[i].y = orig[i].y + rng_jitter(eng);
        perturbed[i].z = orig[i].z + rng_jitter(eng);
      }
      runICP(m_markerConfigurations[1]);
    }
  }

  void readMarkerConfigurations()
  {
    Cloud::Ptr cloud(new Cloud);
    for (int i = 0; i < 4; ++i) {
      cloud->push_back(Point(
        points[i][0] + offset[0],
        points[i][1] + offset[1],
        points[i][2] + offset[2]));
    }
    m_markerConfigurations.push_back(cloud);
    m_markerConfigurations.push_back(cloud);
  }

  void readObjects()
  {
    m_objects.resize(1);
    m_objects[0].markerConfigurationIdx = 0;
    m_objects[0].lastTransformation = 
      pcl::getTransformation(0, 0, 0, 0, 0, 0);
  }

  void runICP(const pcl::PointCloud<pcl::PointXYZ>::ConstPtr markers)
  {
    ICP icp;

    icp.setMaximumIterations(5);
    icp.setInputTarget(markers);
    icp.setMaxCorrespondenceDistance(0.015);

    for (size_t i = 0; i < m_objects.size(); ++i) {
      Object& object = m_objects[i];

      icp.setInputSource(m_markerConfigurations[object.markerConfigurationIdx]);

      // Perform the alignment
      pcl::PointCloud<pcl::PointXYZ> result;
      icp.align(result, object.lastTransformation.matrix());
      if (!icp.hasConverged()) {
        puts("converge failure\n");
        exit(-1);
      }

      Eigen::Matrix4f transformation = icp.getFinalTransformation();
      Eigen::Affine3f tROTA(transformation);
      object.lastTransformation = tROTA;
    }
  }

private:
  std::vector<pcl::PointCloud<pcl::PointXYZ>::Ptr> m_markerConfigurations;
  std::vector<Object> m_objects;
};

int main(int argc, char **argv)
{
  ObjectTracker ot;
  ot.run();
  puts("done");
  return 0;
}
