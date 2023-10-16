;; Auto-generated. Do not edit!


(when (boundp 'crazyswarm::VelocityWorld)
  (if (not (find-package "CRAZYSWARM"))
    (make-package "CRAZYSWARM"))
  (shadow 'VelocityWorld (find-package "CRAZYSWARM")))
(unless (find-package "CRAZYSWARM::VELOCITYWORLD")
  (make-package "CRAZYSWARM::VELOCITYWORLD"))

(in-package "ROS")
;;//! \htmlinclude VelocityWorld.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass crazyswarm::VelocityWorld
  :super ros::object
  :slots (_header _vel _yawRate ))

(defmethod crazyswarm::VelocityWorld
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:vel __vel) (instance geometry_msgs::Vector3 :init))
    ((:yawRate __yawRate) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _vel __vel)
   (setq _yawRate (float __yawRate))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:vel
   (&rest __vel)
   (if (keywordp (car __vel))
       (send* _vel __vel)
     (progn
       (if __vel (setq _vel (car __vel)))
       _vel)))
  (:yawRate
   (&optional __yawRate)
   (if __yawRate (setq _yawRate __yawRate)) _yawRate)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; geometry_msgs/Vector3 _vel
    (send _vel :serialization-length)
    ;; float32 _yawRate
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; geometry_msgs/Vector3 _vel
       (send _vel :serialize s)
     ;; float32 _yawRate
       (sys::poke _yawRate (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; geometry_msgs/Vector3 _vel
     (send _vel :deserialize buf ptr-) (incf ptr- (send _vel :serialization-length))
   ;; float32 _yawRate
     (setq _yawRate (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get crazyswarm::VelocityWorld :md5sum-) "5c7894b98f86c9f4dc7d7cb4971ec39d")
(setf (get crazyswarm::VelocityWorld :datatype-) "crazyswarm/VelocityWorld")
(setf (get crazyswarm::VelocityWorld :definition-)
      "Header header
geometry_msgs/Vector3 vel
float32 yawRate
================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

================================================================================
MSG: geometry_msgs/Vector3
# This represents a vector in free space. 
# It is only meant to represent a direction. Therefore, it does not
# make sense to apply a translation to it (e.g., when applying a 
# generic rigid transformation to a Vector3, tf2 will only apply the
# rotation). If you want your data to be translatable too, use the
# geometry_msgs/Point message instead.

float64 x
float64 y
float64 z
")



(provide :crazyswarm/VelocityWorld "5c7894b98f86c9f4dc7d7cb4971ec39d")


