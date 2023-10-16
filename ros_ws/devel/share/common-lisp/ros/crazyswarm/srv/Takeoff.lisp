; Auto-generated. Do not edit!


(cl:in-package crazyswarm-srv)


;//! \htmlinclude Takeoff-request.msg.html

(cl:defclass <Takeoff-request> (roslisp-msg-protocol:ros-message)
  ((groupMask
    :reader groupMask
    :initarg :groupMask
    :type cl:fixnum
    :initform 0)
   (height
    :reader height
    :initarg :height
    :type cl:float
    :initform 0.0)
   (duration
    :reader duration
    :initarg :duration
    :type cl:real
    :initform 0))
)

(cl:defclass Takeoff-request (<Takeoff-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Takeoff-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Takeoff-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name crazyswarm-srv:<Takeoff-request> is deprecated: use crazyswarm-srv:Takeoff-request instead.")))

(cl:ensure-generic-function 'groupMask-val :lambda-list '(m))
(cl:defmethod groupMask-val ((m <Takeoff-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader crazyswarm-srv:groupMask-val is deprecated.  Use crazyswarm-srv:groupMask instead.")
  (groupMask m))

(cl:ensure-generic-function 'height-val :lambda-list '(m))
(cl:defmethod height-val ((m <Takeoff-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader crazyswarm-srv:height-val is deprecated.  Use crazyswarm-srv:height instead.")
  (height m))

(cl:ensure-generic-function 'duration-val :lambda-list '(m))
(cl:defmethod duration-val ((m <Takeoff-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader crazyswarm-srv:duration-val is deprecated.  Use crazyswarm-srv:duration instead.")
  (duration m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Takeoff-request>) ostream)
  "Serializes a message object of type '<Takeoff-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'groupMask)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'height))))
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Takeoff-request>) istream)
  "Deserializes a message object of type '<Takeoff-request>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'groupMask)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'height) (roslisp-utils:decode-single-float-bits bits)))
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Takeoff-request>)))
  "Returns string type for a service object of type '<Takeoff-request>"
  "crazyswarm/TakeoffRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Takeoff-request)))
  "Returns string type for a service object of type 'Takeoff-request"
  "crazyswarm/TakeoffRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Takeoff-request>)))
  "Returns md5sum for a message object of type '<Takeoff-request>"
  "b665b6c83a196e4774268cc26329b159")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Takeoff-request)))
  "Returns md5sum for a message object of type 'Takeoff-request"
  "b665b6c83a196e4774268cc26329b159")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Takeoff-request>)))
  "Returns full string definition for message of type '<Takeoff-request>"
  (cl:format cl:nil "uint8 groupMask~%float32 height~%duration duration~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Takeoff-request)))
  "Returns full string definition for message of type 'Takeoff-request"
  (cl:format cl:nil "uint8 groupMask~%float32 height~%duration duration~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Takeoff-request>))
  (cl:+ 0
     1
     4
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Takeoff-request>))
  "Converts a ROS message object to a list"
  (cl:list 'Takeoff-request
    (cl:cons ':groupMask (groupMask msg))
    (cl:cons ':height (height msg))
    (cl:cons ':duration (duration msg))
))
;//! \htmlinclude Takeoff-response.msg.html

(cl:defclass <Takeoff-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass Takeoff-response (<Takeoff-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Takeoff-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Takeoff-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name crazyswarm-srv:<Takeoff-response> is deprecated: use crazyswarm-srv:Takeoff-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Takeoff-response>) ostream)
  "Serializes a message object of type '<Takeoff-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Takeoff-response>) istream)
  "Deserializes a message object of type '<Takeoff-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Takeoff-response>)))
  "Returns string type for a service object of type '<Takeoff-response>"
  "crazyswarm/TakeoffResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Takeoff-response)))
  "Returns string type for a service object of type 'Takeoff-response"
  "crazyswarm/TakeoffResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Takeoff-response>)))
  "Returns md5sum for a message object of type '<Takeoff-response>"
  "b665b6c83a196e4774268cc26329b159")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Takeoff-response)))
  "Returns md5sum for a message object of type 'Takeoff-response"
  "b665b6c83a196e4774268cc26329b159")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Takeoff-response>)))
  "Returns full string definition for message of type '<Takeoff-response>"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Takeoff-response)))
  "Returns full string definition for message of type 'Takeoff-response"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Takeoff-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Takeoff-response>))
  "Converts a ROS message object to a list"
  (cl:list 'Takeoff-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'Takeoff)))
  'Takeoff-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'Takeoff)))
  'Takeoff-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Takeoff)))
  "Returns string type for a service object of type '<Takeoff>"
  "crazyswarm/Takeoff")