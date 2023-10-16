#include "libobjecttracker/object_tracker.h"
#include "libobjecttracker/cloudlog.hpp"
#include "yaml-cpp/yaml.h"

#include <cassert>
#include <fstream>
#include <iostream>
#include <streambuf>
#include <string>

static std::string YAMLDIR = "../../../../crazyswarm/launch";

static void log_stderr(std::string s)
{
  std::cout << s << "\n";
}

static pcl::PointXYZ eig2pcl(Eigen::Vector3f v)
{
  return pcl::PointXYZ(v.x(), v.y(), v.z());
}

std::string wholefile(std::string path)
{
  std::ifstream t(path);
  std::string str;

  t.seekg(0, std::ios::end);   
  str.reserve(t.tellg());
  t.seekg(0, std::ios::beg);

  str.assign((std::istreambuf_iterator<char>(t)),
              std::istreambuf_iterator<char>());

  return str;
}

YAML::Node rosparams()
{
  std::string file = wholefile(YAMLDIR + "/hover_swarm.launch");
  auto begin = file.find("<rosparam>") + strlen("<rosparam>");
  auto end = file.find("</rosparam>");
  return YAML::Load(file.substr(begin, end - begin));
}

Eigen::Vector3f asVec(YAML::Node const &node)
{
  assert(node.IsSequence());
  assert(node.size() == 3);
  return Eigen::Vector3f(
    node[0].as<float>(), node[1].as<float>(), node[2].as<float>());
}

static void readMarkerConfigurations(
  std::vector<libobjecttracker::MarkerConfiguration>& markerConfigurations)
{
  YAML::Node config_root = rosparams();
  auto markerRoot = config_root["markerConfigurations"];
  assert(markerRoot.IsMap());

  markerConfigurations.clear();
  for (auto &&config : markerRoot) {
    auto val = config.second; // first is key
    assert(val.IsMap());
    auto offset = asVec(val["offset"]);
    markerConfigurations.push_back(pcl::PointCloud<pcl::PointXYZ>::Ptr(
      new pcl::PointCloud<pcl::PointXYZ>));
    for (auto &&point : val["points"]) {
      auto pt = asVec(point.second) + offset;
      markerConfigurations.back()->push_back(eig2pcl(pt));
    }
  }
}

static void readDynamicsConfigurations(
  std::vector<libobjecttracker::DynamicsConfiguration>& dynamicsConfigurations)
{
  YAML::Node config_root = rosparams();
  auto dynRoot = config_root["dynamicsConfigurations"];
  assert(dynRoot.IsMap());

  dynamicsConfigurations.clear();
  for (auto &&dyn : dynRoot) {
    auto val = dyn.second; // first is key
    assert(val.IsMap());
    dynamicsConfigurations.push_back(libobjecttracker::DynamicsConfiguration());
    auto &conf = dynamicsConfigurations.back();
    conf.maxXVelocity = val["maxXVelocity"].as<float>();
    conf.maxYVelocity = val["maxYVelocity"].as<float>();
    conf.maxZVelocity = val["maxZVelocity"].as<float>();
    conf.maxPitchRate = val["maxPitchRate"].as<float>();
    conf.maxRollRate = val["maxRollRate"].as<float>();
    conf.maxYawRate = val["maxYawRate"].as<float>();
    conf.maxRoll = val["maxRoll"].as<float>();
    conf.maxPitch = val["maxPitch"].as<float>();
    conf.maxFitnessScore = val["maxFitnessScore"].as<float>();
  }
}

static void readObjects(std::vector<libobjecttracker::Object>& objects)
{
  YAML::Node cfs_root = YAML::LoadFile(YAMLDIR + "/crazyflies.yaml");
  auto cfs = cfs_root["crazyflies"];
  assert(cfs.IsSequence());
  for (auto &&cf : cfs) {
    assert(cf.IsMap());
    auto initPos = cf["initialPosition"];
    Eigen::Affine3f xf(Eigen::Translation3f(asVec(initPos)));
    objects.emplace_back(0, 0, xf);
  }
}

int main(int argc, char **argv)
{
  using namespace libobjecttracker;

  if (argc < 2) {
    std::cerr << "error: requres filename arugment\n";
    return -1;
  }

  std::vector<DynamicsConfiguration> dynamicsConfigurations;
  std::vector<MarkerConfiguration> markerConfigurations;
  std::vector<Object> objects;

  readMarkerConfigurations(markerConfigurations);
  readDynamicsConfigurations(dynamicsConfigurations);
  readObjects(objects);

  std::cout << dynamicsConfigurations.size() << " dynamics configurations, "
            << markerConfigurations.size() << " marker configurations, "
            << objects.size() << " crazyflies.\n";

  libobjecttracker::ObjectTracker tracker(
    dynamicsConfigurations,
    markerConfigurations,
    objects);

  tracker.setLogWarningCallback(&log_stderr);
  if (argc < 3) {
    PointCloudPlayer player;
    player.load(argv[1]);
    player.play(tracker);
  }
  else {
    PointCloudDebugger debugger(argv[2]);
    debugger.load(argv[1]);
    debugger.convert(tracker,markerConfigurations);
  }
}
