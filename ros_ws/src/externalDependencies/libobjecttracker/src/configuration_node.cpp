#include "ros/ros.h"
#include <sensor_msgs/PointCloud.h>
#include <iostream>

void pointCloudCallback(const sensor_msgs::PointCloud::ConstPtr pointCloud)
{
  std::cout << "    numPoints: " << pointCloud->points.size() << std::endl;
  std::cout << "    points:" << std::endl;

  for(size_t i = 0; i < pointCloud->points.size(); ++i) {
    std::cout << "      \"" << i << "\": ["
              << pointCloud->points[i].x << ","
              << pointCloud->points[i].y << ","
              << pointCloud->points[i].z << "]"
              << std::endl;
  }
}

int main(int argc, char **argv)
{
  ros::init(argc, argv, "configuration");

  ros::NodeHandle n;

  ros::Subscriber sub = n.subscribe("/vicon/pointCloud", 1, pointCloudCallback);

  ros::spin();

  return 0;
}
