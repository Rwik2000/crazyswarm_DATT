; Auto-generated. Do not edit!


(cl:in-package crazyswarm-srv)


;//! \htmlinclude Land-request.msg.html

(cl:defclass <Land-request> (roslisp-msg-protocol:ros-message)
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

(cl:defclass Land-request (<Land-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Land-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Land-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name crazyswarm-srv:<Land-request> is deprecated: use crazyswarm-srv:Land-request instead.")))

(cl:ensure-generic-function 'groupMask-val :lambda-list '(m))
(cl:defmethod groupMask-val ((m <Land-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader crazyswarm-srv:groupMask-val is deprecated.  Use crazyswarm-srv:groupMask instead.")
  (groupMask m))

(cl:ensure-generic-function 'height-val :lambda-list '(m))
(cl:defmethod height-val ((m <Land-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader crazyswarm-srv:height-val is deprecated.  Use crazyswarm-srv:height instead.")
  (height m))

(cl:ensure-generic-function 'duration-val :lambda-list '(m))
(cl:defmethod duration-val ((m <Land-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader crazyswarm-srv:duration-val is deprecated.  Use crazyswarm-srv:duration instead.")
  (duration m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Land-request>) ostream)
  "Serializes a message object of type '<Land-request>"
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Land-request>) istream)
  "Deserializes a message object of type '<Land-request>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Land-request>)))
  "Returns string type for a service object of type '<Land-request>"
  "crazyswarm/LandRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Land-request)))
  "Returns string type for a service object of type 'Land-request"
  "crazyswarm/LandRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Land-request>)))
  "Returns md5sum for a message object of type '<Land-request>"
  "b665b6c83a196e4774268cc26329b159")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Land-request)))
  "Returns md5sum for a message object of type 'Land-request"
  "b665b6c83a196e4774268cc26329b159")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Land-request>)))
  "Returns full string definition for message of type '<Land-request>"
  (cl:format cl:nil "uint8 groupMask~%float32 height~%duration duration~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Land-request)))
  "Returns full string definition for message of type 'Land-request"
  (cl:format cl:nil "uint8 groupMask~%float32 height~%duration duration~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Land-request>))
  (cl:+ 0
     1
     4
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Land-request>))
  "Converts a ROS message object to a list"
  (cl:list 'Land-request
    (cl:cons ':groupMask (groupMask msg))
    (cl:cons ':height (height msg))
    (cl:cons ':duration (duration msg))
))
;//! \htmlinclude Land-response.msg.html

(cl:defclass <Land-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass Land-response (<Land-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Land-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Land-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name crazyswarm-srv:<Land-response> is deprecated: use crazyswarm-srv:Land-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Land-response>) ostream)
  "Serializes a message object of type '<Land-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Land-response>) istream)
  "Deserializes a message object of type '<Land-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Land-response>)))
  "Returns string type for a service object of type '<Land-response>"
  "crazyswarm/LandResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Land-response)))
  "Returns string type for a service object of type 'Land-response"
  "crazyswarm/LandResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Land-response>)))
  "Returns md5sum for a message object of type '<Land-response>"
  "b665b6c83a196e4774268cc26329b159")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Land-response)))
  "Returns md5sum for a message object of type 'Land-response"
  "b665b6c83a196e4774268cc26329b159")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Land-response>)))
  "Returns full string definition for message of type '<Land-response>"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Land-response)))
  "Returns full string definition for message of type 'Land-response"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Land-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Land-response>))
  "Converts a ROS message object to a list"
  (cl:list 'Land-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'Land)))
  'Land-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'Land)))
  'Land-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Land)))
  "Returns string type for a service object of type '<Land>"
  "crazyswarm/Land")