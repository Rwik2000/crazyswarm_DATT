#pragma once
#include "libmotioncapture/motioncapture.h"

namespace libmotioncapture {
  class MotionCaptureTestImpl;

  class MotionCaptureTest : public MotionCapture{
  public:
    MotionCaptureTest(
      float dt,
      const std::vector<RigidBody>& objects);//,
      // const pcl::PointCloud<pcl::PointXYZ>::Ptr pointCloud);

    virtual ~MotionCaptureTest();

    // implementations for MotionCapture interface
    virtual void waitForNextFrame();

    virtual bool supportsRigidBodyTracking() const
    {
      return true;
    }

    virtual bool supportsPointCloud() const
    {
      return true;
    }

  private:
    MotionCaptureTestImpl * pImpl;
  };
}

