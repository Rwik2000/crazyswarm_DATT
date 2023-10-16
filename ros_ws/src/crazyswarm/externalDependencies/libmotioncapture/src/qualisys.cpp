// For windows, make sure that M_PI will be defined
#define _USE_MATH_DEFINES
#include <cmath>

#include "libmotioncapture/qualisys.h"

// Qualisys
#include "RTProtocol.h"

#include <string>
#include <sstream>

namespace libmotioncapture {

  class MotionCaptureQualisysImpl
  {
  public:
    CRTProtocol poRTProtocol;
    CRTPacket*  pRTPacket;
    CRTPacket::EComponentType componentType;
    std::string version;
  };

  MotionCaptureQualisys::MotionCaptureQualisys(
    const std::string& hostname,
    int basePort,
    bool enableObjects,
    bool enablePointcloud)
  {
    pImpl = new MotionCaptureQualisysImpl;

    // Connecting ...
    if (!pImpl->poRTProtocol.Connect((char*)hostname.c_str(), basePort, 0, 1, 7)) {
      std::stringstream sstr;
      sstr << "Error connecting QTM on address: " << hostname << ":" << basePort;
      throw std::runtime_error(sstr.str());
    }
    pImpl->pRTPacket = pImpl->poRTProtocol.GetRTPacket();

    // Setting component flag
    pImpl->componentType = static_cast<CRTPacket::EComponentType>(0);
    if (enableObjects) {
      pImpl->componentType = static_cast<CRTPacket::EComponentType>(pImpl->componentType | CRTPacket::Component6dEuler);
    }
    if (enablePointcloud) {
      pImpl->componentType = static_cast<CRTPacket::EComponentType>(pImpl->componentType | CRTPacket::Component3dNoLabels);
    }

    // Get 6DOF settings
    bool dataAvailable;
    pImpl->poRTProtocol.Read6DOFSettings(dataAvailable);

    // TODO: enable UDP streaming of selected component for lower latency?

    // Getting version
    char qtmVersion[255];
    unsigned int major, minor;
    pImpl->poRTProtocol.GetQTMVersion(qtmVersion, 255);
    pImpl->poRTProtocol.GetVersion(major, minor);
    std::stringstream sstr;
    sstr << qtmVersion << " (Protocol: " << major << "." << minor <<")";
    pImpl->version  = sstr.str();
  }

  MotionCaptureQualisys::~MotionCaptureQualisys()
  {
    delete pImpl;
  }

  const std::string& MotionCaptureQualisys::version() const
  {
    return pImpl->version;
  }

  void MotionCaptureQualisys::waitForNextFrame()
  {
    CRTPacket::EPacketType eType;

    pImpl->poRTProtocol.GetCurrentFrame(pImpl->componentType);

    do {
      pImpl->poRTProtocol.ReceiveRTPacket(eType, true);
    } while(eType != CRTPacket::PacketData);
  }

  const std::map<std::string, RigidBody>& MotionCaptureQualisys::rigidBodies() const
  {
    float pos[3], rx, ry, rz;

    rigidBodies_.clear();
    size_t count = pImpl->pRTPacket->Get6DOFEulerBodyCount();

    for(size_t i = 0; i < count; ++i) {
      std::string name = std::string(pImpl->poRTProtocol.Get6DOFBodyName(i));
      pImpl->pRTPacket->Get6DOFEulerBody(i, pos[0], pos[1], pos[2], rx, ry, rz);
      if (!std::isnan(pos[0])) {
        Eigen::Vector3f position = Eigen::Vector3f(pos) / 1000.0;

        Eigen::Matrix3f rotation;
        rotation = Eigen::AngleAxisf((rx/180.0f)*M_PI, Eigen::Vector3f::UnitX())
                 * Eigen::AngleAxisf((ry/180.0f)*M_PI, Eigen::Vector3f::UnitY())
                 * Eigen::AngleAxisf((rz/180.0f)*M_PI, Eigen::Vector3f::UnitZ());
        Eigen::Quaternionf quaternion = Eigen::Quaternionf(rotation);

        rigidBodies_.emplace(name, RigidBody(name, position, quaternion));
      }
    }
    return rigidBodies_;
  }

  RigidBody MotionCaptureQualisys::rigidBodyByName(const std::string &name) const
  {
    // Find object index
    size_t bodyCount = pImpl->pRTPacket->Get6DOFEulerBodyCount();
    size_t bodyId;
    for (bodyId = 0; bodyId < bodyCount; ++bodyId) {
      if (!strcmp(name.c_str(), pImpl->poRTProtocol.Get6DOFBodyName(bodyId))) {
        break;
      }
    }

    // If found, get object position
    if (bodyId < bodyCount) {
      float pos[3], rx, ry, rz;

      pImpl->pRTPacket->Get6DOFEulerBody(bodyId, pos[0], pos[1], pos[2], rx, ry, rz);

      if (!std::isnan(pos[0])) {
        Eigen::Vector3f position = Eigen::Vector3f(pos) / 1000.0;

        Eigen::Matrix3f rotation;
        rotation = Eigen::AngleAxisf((rx/180.0f)*M_PI, Eigen::Vector3f::UnitX())
                 * Eigen::AngleAxisf((ry/180.0f)*M_PI, Eigen::Vector3f::UnitY())
                 * Eigen::AngleAxisf((rz/180.0f)*M_PI, Eigen::Vector3f::UnitZ());
        Eigen::Quaternionf quaternion = Eigen::Quaternionf(rotation);

        return RigidBody(name, position, quaternion);
      }
    }
    throw std::runtime_error("Unknown rigid body!");
  }

  const PointCloud& MotionCaptureQualisys::pointCloud() const
  {
    size_t count = pImpl->pRTPacket->Get3DNoLabelsMarkerCount();
    pointcloud_.resize(count, Eigen::NoChange);
    for(size_t i = 0; i < count; ++i) {
      float x, y, z;
      unsigned int nId;
      pImpl->pRTPacket->Get3DNoLabelsMarker(i, x, y, z, nId);
      pointcloud_.row(i) << x / 1000.0, y / 1000.0, z / 1000.0;
    }
    return pointcloud_;
  }

  uint64_t MotionCaptureQualisys::timeStamp() const
  {
    return pImpl->pRTPacket->GetTimeStamp();
  }

}
