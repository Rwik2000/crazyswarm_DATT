; Auto-generated. Do not edit!


(cl:in-package crazyswarm-msg)


;//! \htmlinclude VelocityWorld.msg.html

(cl:defclass <VelocityWorld> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (vel
    :reader vel
    :initarg :vel
    :type geometry_msgs-msg:Vector3
    :initform (cl:make-instance 'geometry_msgs-msg:Vector3))
   (yawRate
    :reader yawRate
    :initarg :yawRate
    :type cl:float
    :initform 0.0))
)

(cl:defclass VelocityWorld (<VelocityWorld>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <VelocityWorld>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'VelocityWorld)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name crazyswarm-msg:<VelocityWorld> is deprecated: use crazyswarm-msg:VelocityWorld instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <VelocityWorld>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader crazyswarm-msg:header-val is deprecated.  Use crazyswarm-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'vel-val :lambda-list '(m))
(cl:defmethod vel-val ((m <VelocityWorld>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader crazyswarm-msg:vel-val is deprecated.  Use crazyswarm-msg:vel instead.")
  (vel m))

(cl:ensure-generic-function 'yawRate-val :lambda-list '(m))
(cl:defmethod yawRate-val ((m <VelocityWorld>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader crazyswarm-msg:yawRate-val is deprecated.  Use crazyswarm-msg:yawRate instead.")
  (yawRate m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <VelocityWorld>) ostream)
  "Serializes a message object of type '<VelocityWorld>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'vel) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'yawRate))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <VelocityWorld>) istream)
  "Deserializes a message object of type '<VelocityWorld>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'vel) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'yawRate) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<VelocityWorld>)))
  "Returns string type for a message object of type '<VelocityWorld>"
  "crazyswarm/VelocityWorld")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'VelocityWorld)))
  "Returns string type for a message object of type 'VelocityWorld"
  "crazyswarm/VelocityWorld")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<VelocityWorld>)))
  "Returns md5sum for a message object of type '<VelocityWorld>"
  "5c7894b98f86c9f4dc7d7cb4971ec39d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'VelocityWorld)))
  "Returns md5sum for a message object of type 'VelocityWorld"
  "5c7894b98f86c9f4dc7d7cb4971ec39d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<VelocityWorld>)))
  "Returns full string definition for message of type '<VelocityWorld>"
  (cl:format cl:nil "Header header~%geometry_msgs/Vector3 vel~%float32 yawRate~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'VelocityWorld)))
  "Returns full string definition for message of type 'VelocityWorld"
  (cl:format cl:nil "Header header~%geometry_msgs/Vector3 vel~%float32 yawRate~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <VelocityWorld>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'vel))
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <VelocityWorld>))
  "Converts a ROS message object to a list"
  (cl:list 'VelocityWorld
    (cl:cons ':header (header msg))
    (cl:cons ':vel (vel msg))
    (cl:cons ':yawRate (yawRate msg))
))
