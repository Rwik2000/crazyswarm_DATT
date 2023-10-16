// Generated by gencpp from file crazyswarm/StartTrajectory.msg
// DO NOT EDIT!


#ifndef CRAZYSWARM_MESSAGE_STARTTRAJECTORY_H
#define CRAZYSWARM_MESSAGE_STARTTRAJECTORY_H

#include <ros/service_traits.h>


#include <crazyswarm/StartTrajectoryRequest.h>
#include <crazyswarm/StartTrajectoryResponse.h>


namespace crazyswarm
{

struct StartTrajectory
{

typedef StartTrajectoryRequest Request;
typedef StartTrajectoryResponse Response;
Request request;
Response response;

typedef Request RequestType;
typedef Response ResponseType;

}; // struct StartTrajectory
} // namespace crazyswarm


namespace ros
{
namespace service_traits
{


template<>
struct MD5Sum< ::crazyswarm::StartTrajectory > {
  static const char* value()
  {
    return "74e2cf5224bc82fcc8d9c7dd3865d912";
  }

  static const char* value(const ::crazyswarm::StartTrajectory&) { return value(); }
};

template<>
struct DataType< ::crazyswarm::StartTrajectory > {
  static const char* value()
  {
    return "crazyswarm/StartTrajectory";
  }

  static const char* value(const ::crazyswarm::StartTrajectory&) { return value(); }
};


// service_traits::MD5Sum< ::crazyswarm::StartTrajectoryRequest> should match
// service_traits::MD5Sum< ::crazyswarm::StartTrajectory >
template<>
struct MD5Sum< ::crazyswarm::StartTrajectoryRequest>
{
  static const char* value()
  {
    return MD5Sum< ::crazyswarm::StartTrajectory >::value();
  }
  static const char* value(const ::crazyswarm::StartTrajectoryRequest&)
  {
    return value();
  }
};

// service_traits::DataType< ::crazyswarm::StartTrajectoryRequest> should match
// service_traits::DataType< ::crazyswarm::StartTrajectory >
template<>
struct DataType< ::crazyswarm::StartTrajectoryRequest>
{
  static const char* value()
  {
    return DataType< ::crazyswarm::StartTrajectory >::value();
  }
  static const char* value(const ::crazyswarm::StartTrajectoryRequest&)
  {
    return value();
  }
};

// service_traits::MD5Sum< ::crazyswarm::StartTrajectoryResponse> should match
// service_traits::MD5Sum< ::crazyswarm::StartTrajectory >
template<>
struct MD5Sum< ::crazyswarm::StartTrajectoryResponse>
{
  static const char* value()
  {
    return MD5Sum< ::crazyswarm::StartTrajectory >::value();
  }
  static const char* value(const ::crazyswarm::StartTrajectoryResponse&)
  {
    return value();
  }
};

// service_traits::DataType< ::crazyswarm::StartTrajectoryResponse> should match
// service_traits::DataType< ::crazyswarm::StartTrajectory >
template<>
struct DataType< ::crazyswarm::StartTrajectoryResponse>
{
  static const char* value()
  {
    return DataType< ::crazyswarm::StartTrajectory >::value();
  }
  static const char* value(const ::crazyswarm::StartTrajectoryResponse&)
  {
    return value();
  }
};

} // namespace service_traits
} // namespace ros

#endif // CRAZYSWARM_MESSAGE_STARTTRAJECTORY_H