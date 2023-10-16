; Auto-generated. Do not edit!


(cl:in-package crazyswarm-srv)


;//! \htmlinclude StartTrajectory-request.msg.html

(cl:defclass <StartTrajectory-request> (roslisp-msg-protocol:ros-message)
  ((groupMask
    :reader groupMask
    :initarg :groupMask
    :type cl:fixnum
    :initform 0)
   (trajectoryId
    :reader trajectoryId
    :initarg :trajectoryId
    :type cl:fixnum
    :initform 0)
   (timescale
    :reader timescale
    :initarg :timescale
    :type cl:float
    :initform 0.0)
   (reversed
    :reader reversed
    :initarg :reversed
    :type cl:boolean
    :initform cl:nil)
   (relative
    :reader relative
    :initarg :relative
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass StartTrajectory-request (<StartTrajectory-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <StartTrajectory-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'StartTrajectory-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name crazyswarm-srv:<StartTrajectory-request> is deprecated: use crazyswarm-srv:StartTrajectory-request instead.")))

(cl:ensure-generic-function 'groupMask-val :lambda-list '(m))
(cl:defmethod groupMask-val ((m <StartTrajectory-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader crazyswarm-srv:groupMask-val is deprecated.  Use crazyswarm-srv:groupMask instead.")
  (groupMask m))

(cl:ensure-generic-function 'trajectoryId-val :lambda-list '(m))
(cl:defmethod trajectoryId-val ((m <StartTrajectory-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader crazyswarm-srv:trajectoryId-val is deprecated.  Use crazyswarm-srv:trajectoryId instead.")
  (trajectoryId m))

(cl:ensure-generic-function 'timescale-val :lambda-list '(m))
(cl:defmethod timescale-val ((m <StartTrajectory-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader crazyswarm-srv:timescale-val is deprecated.  Use crazyswarm-srv:timescale instead.")
  (timescale m))

(cl:ensure-generic-function 'reversed-val :lambda-list '(m))
(cl:defmethod reversed-val ((m <StartTrajectory-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader crazyswarm-srv:reversed-val is deprecated.  Use crazyswarm-srv:reversed instead.")
  (reversed m))

(cl:ensure-generic-function 'relative-val :lambda-list '(m))
(cl:defmethod relative-val ((m <StartTrajectory-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader crazyswarm-srv:relative-val is deprecated.  Use crazyswarm-srv:relative instead.")
  (relative m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <StartTrajectory-request>) ostream)
  "Serializes a message object of type '<StartTrajectory-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'groupMask)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'trajectoryId)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'timescale))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'reversed) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'relative) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <StartTrajectory-request>) istream)
  "Deserializes a message object of type '<StartTrajectory-request>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'groupMask)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'trajectoryId)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'timescale) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'reversed) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'relative) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<StartTrajectory-request>)))
  "Returns string type for a service object of type '<StartTrajectory-request>"
  "crazyswarm/StartTrajectoryRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'StartTrajectory-request)))
  "Returns string type for a service object of type 'StartTrajectory-request"
  "crazyswarm/StartTrajectoryRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<StartTrajectory-request>)))
  "Returns md5sum for a message object of type '<StartTrajectory-request>"
  "74e2cf5224bc82fcc8d9c7dd3865d912")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'StartTrajectory-request)))
  "Returns md5sum for a message object of type 'StartTrajectory-request"
  "74e2cf5224bc82fcc8d9c7dd3865d912")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<StartTrajectory-request>)))
  "Returns full string definition for message of type '<StartTrajectory-request>"
  (cl:format cl:nil "uint8 groupMask~%uint8 trajectoryId~%float32 timescale~%bool reversed~%bool relative~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'StartTrajectory-request)))
  "Returns full string definition for message of type 'StartTrajectory-request"
  (cl:format cl:nil "uint8 groupMask~%uint8 trajectoryId~%float32 timescale~%bool reversed~%bool relative~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <StartTrajectory-request>))
  (cl:+ 0
     1
     1
     4
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <StartTrajectory-request>))
  "Converts a ROS message object to a list"
  (cl:list 'StartTrajectory-request
    (cl:cons ':groupMask (groupMask msg))
    (cl:cons ':trajectoryId (trajectoryId msg))
    (cl:cons ':timescale (timescale msg))
    (cl:cons ':reversed (reversed msg))
    (cl:cons ':relative (relative msg))
))
;//! \htmlinclude StartTrajectory-response.msg.html

(cl:defclass <StartTrajectory-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass StartTrajectory-response (<StartTrajectory-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <StartTrajectory-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'StartTrajectory-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name crazyswarm-srv:<StartTrajectory-response> is deprecated: use crazyswarm-srv:StartTrajectory-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <StartTrajectory-response>) ostream)
  "Serializes a message object of type '<StartTrajectory-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <StartTrajectory-response>) istream)
  "Deserializes a message object of type '<StartTrajectory-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<StartTrajectory-response>)))
  "Returns string type for a service object of type '<StartTrajectory-response>"
  "crazyswarm/StartTrajectoryResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'StartTrajectory-response)))
  "Returns string type for a service object of type 'StartTrajectory-response"
  "crazyswarm/StartTrajectoryResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<StartTrajectory-response>)))
  "Returns md5sum for a message object of type '<StartTrajectory-response>"
  "74e2cf5224bc82fcc8d9c7dd3865d912")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'StartTrajectory-response)))
  "Returns md5sum for a message object of type 'StartTrajectory-response"
  "74e2cf5224bc82fcc8d9c7dd3865d912")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<StartTrajectory-response>)))
  "Returns full string definition for message of type '<StartTrajectory-response>"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'StartTrajectory-response)))
  "Returns full string definition for message of type 'StartTrajectory-response"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <StartTrajectory-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <StartTrajectory-response>))
  "Converts a ROS message object to a list"
  (cl:list 'StartTrajectory-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'StartTrajectory)))
  'StartTrajectory-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'StartTrajectory)))
  'StartTrajectory-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'StartTrajectory)))
  "Returns string type for a service object of type '<StartTrajectory>"
  "crazyswarm/StartTrajectory")