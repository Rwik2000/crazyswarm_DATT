#include "libmotioncapture/testmocap.h"

#include <thread>

namespace libmotioncapture {

  class MotionCaptureTestImpl{
  public:
    MotionCaptureTestImpl()
    {
    }

  public:
    float dt;
  };

  MotionCaptureTest::MotionCaptureTest(
    float dt,
    const std::vector<RigidBody>& objects)//,
    // const pcl::PointCloud<pcl::PointXYZ>::Ptr pointCloud)
  {
    pImpl = new MotionCaptureTestImpl;
    pImpl->dt = dt;
    for (const auto& obj : objects) {
      rigidBodies_.insert(std::make_pair(obj.name(), obj));
    }
    Eigen::Quaternionf q(0,0,0,1); 
    rigidBodies_.emplace("test", RigidBody("test", Eigen::Vector3f(0,1,2), q));
    // pointcloud_ = pointCloud;
  }

  void MotionCaptureTest::waitForNextFrame()
  {
    std::this_thread::sleep_for(std::chrono::milliseconds((int)(pImpl->dt * 1000)));
  }

  MotionCaptureTest::~MotionCaptureTest()
  {
    delete pImpl;
  }
}

