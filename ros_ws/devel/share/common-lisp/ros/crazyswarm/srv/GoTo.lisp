; Auto-generated. Do not edit!


(cl:in-package crazyswarm-srv)


;//! \htmlinclude GoTo-request.msg.html

(cl:defclass <GoTo-request> (roslisp-msg-protocol:ros-message)
  ((groupMask
    :reader groupMask
    :initarg :groupMask
    :type cl:fixnum
    :initform 0)
   (relative
    :reader relative
    :initarg :relative
    :type cl:boolean
    :initform cl:nil)
   (goal
    :reader goal
    :initarg :goal
    :type geometry_msgs-msg:Point
    :initform (cl:make-instance 'geometry_msgs-msg:Point))
   (yaw
    :reader yaw
    :initarg :yaw
    :type cl:float
    :initform 0.0)
   (duration
    :reader duration
    :initarg :duration
    :type cl:real
    :initform 0))
)

(cl:defclass GoTo-request (<GoTo-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GoTo-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GoTo-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name crazyswarm-srv:<GoTo-request> is deprecated: use crazyswarm-srv:GoTo-request instead.")))

(cl:ensure-generic-function 'groupMask-val :lambda-list '(m))
(cl:defmethod groupMask-val ((m <GoTo-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader crazyswarm-srv:groupMask-val is deprecated.  Use crazyswarm-srv:groupMask instead.")
  (groupMask m))

(cl:ensure-generic-function 'relative-val :lambda-list '(m))
(cl:defmethod relative-val ((m <GoTo-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader crazyswarm-srv:relative-val is deprecated.  Use crazyswarm-srv:relative instead.")
  (relative m))

(cl:ensure-generic-function 'goal-val :lambda-list '(m))
(cl:defmethod goal-val ((m <GoTo-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader crazyswarm-srv:goal-val is deprecated.  Use crazyswarm-srv:goal instead.")
  (goal m))

(cl:ensure-generic-function 'yaw-val :lambda-list '(m))
(cl:defmethod yaw-val ((m <GoTo-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader crazyswarm-srv:yaw-val is deprecated.  Use crazyswarm-srv:yaw instead.")
  (yaw m))

(cl:ensure-generic-function 'duration-val :lambda-list '(m))
(cl:defmethod duration-val ((m <GoTo-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader crazyswarm-srv:duration-val is deprecated.  Use crazyswarm-srv:duration instead.")
  (duration m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GoTo-request>) ostream)
  "Serializes a message object of type '<GoTo-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'groupMask)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'relative) 1 0)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'goal) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'yaw))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__sec (cl:floor (cl:slot-value msg 'duration)))
        (__nsec (cl:round (cl:* 1e9 (cl:- (cl:slot-value msg 'duration) (cl:floor (cl:slot-value msg 'duration)))))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 0) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __nsec) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GoTo-request>) istream)
  "Deserializes a message object of type '<GoTo-request>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'groupMask)) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'relative) (cl:not (cl:zerop (cl:read-byte istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'goal) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'yaw) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((__sec 0) (__nsec 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 0) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __nsec) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'duration) (cl:+ (cl:coerce __sec 'cl:double-float) (cl:/ __nsec 1e9))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GoTo-request>)))
  "Returns string type for a service object of type '<GoTo-request>"
  "crazyswarm/GoToRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GoTo-request)))
  "Returns string type for a service object of type 'GoTo-request"
  "crazyswarm/GoToRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GoTo-request>)))
  "Returns md5sum for a message object of type '<GoTo-request>"
  "82856b48a972d6af023d961a655bcf75")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GoTo-request)))
  "Returns md5sum for a message object of type 'GoTo-request"
  "82856b48a972d6af023d961a655bcf75")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GoTo-request>)))
  "Returns full string definition for message of type '<GoTo-request>"
  (cl:format cl:nil "uint8 groupMask~%bool relative~%geometry_msgs/Point goal~%float32 yaw # deg~%duration duration~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GoTo-request)))
  "Returns full string definition for message of type 'GoTo-request"
  (cl:format cl:nil "uint8 groupMask~%bool relative~%geometry_msgs/Point goal~%float32 yaw # deg~%duration duration~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GoTo-request>))
  (cl:+ 0
     1
     1
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'goal))
     4
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GoTo-request>))
  "Converts a ROS message object to a list"
  (cl:list 'GoTo-request
    (cl:cons ':groupMask (groupMask msg))
    (cl:cons ':relative (relative msg))
    (cl:cons ':goal (goal msg))
    (cl:cons ':yaw (yaw msg))
    (cl:cons ':duration (duration msg))
))
;//! \htmlinclude GoTo-response.msg.html

(cl:defclass <GoTo-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass GoTo-response (<GoTo-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GoTo-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GoTo-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name crazyswarm-srv:<GoTo-response> is deprecated: use crazyswarm-srv:GoTo-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GoTo-response>) ostream)
  "Serializes a message object of type '<GoTo-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GoTo-response>) istream)
  "Deserializes a message object of type '<GoTo-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GoTo-response>)))
  "Returns string type for a service object of type '<GoTo-response>"
  "crazyswarm/GoToResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GoTo-response)))
  "Returns string type for a service object of type 'GoTo-response"
  "crazyswarm/GoToResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GoTo-response>)))
  "Returns md5sum for a message object of type '<GoTo-response>"
  "82856b48a972d6af023d961a655bcf75")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GoTo-response)))
  "Returns md5sum for a message object of type 'GoTo-response"
  "82856b48a972d6af023d961a655bcf75")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GoTo-response>)))
  "Returns full string definition for message of type '<GoTo-response>"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GoTo-response)))
  "Returns full string definition for message of type 'GoTo-response"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GoTo-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GoTo-response>))
  "Converts a ROS message object to a list"
  (cl:list 'GoTo-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'GoTo)))
  'GoTo-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'GoTo)))
  'GoTo-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GoTo)))
  "Returns string type for a service object of type '<GoTo>"
  "crazyswarm/GoTo")