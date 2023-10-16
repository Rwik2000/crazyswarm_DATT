; Auto-generated. Do not edit!


(cl:in-package crazyswarm-srv)


;//! \htmlinclude NotifySetpointsStop-request.msg.html

(cl:defclass <NotifySetpointsStop-request> (roslisp-msg-protocol:ros-message)
  ((groupMask
    :reader groupMask
    :initarg :groupMask
    :type cl:fixnum
    :initform 0)
   (remainValidMillisecs
    :reader remainValidMillisecs
    :initarg :remainValidMillisecs
    :type cl:integer
    :initform 0))
)

(cl:defclass NotifySetpointsStop-request (<NotifySetpointsStop-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <NotifySetpointsStop-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'NotifySetpointsStop-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name crazyswarm-srv:<NotifySetpointsStop-request> is deprecated: use crazyswarm-srv:NotifySetpointsStop-request instead.")))

(cl:ensure-generic-function 'groupMask-val :lambda-list '(m))
(cl:defmethod groupMask-val ((m <NotifySetpointsStop-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader crazyswarm-srv:groupMask-val is deprecated.  Use crazyswarm-srv:groupMask instead.")
  (groupMask m))

(cl:ensure-generic-function 'remainValidMillisecs-val :lambda-list '(m))
(cl:defmethod remainValidMillisecs-val ((m <NotifySetpointsStop-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader crazyswarm-srv:remainValidMillisecs-val is deprecated.  Use crazyswarm-srv:remainValidMillisecs instead.")
  (remainValidMillisecs m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <NotifySetpointsStop-request>) ostream)
  "Serializes a message object of type '<NotifySetpointsStop-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'groupMask)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'remainValidMillisecs)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'remainValidMillisecs)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'remainValidMillisecs)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'remainValidMillisecs)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <NotifySetpointsStop-request>) istream)
  "Deserializes a message object of type '<NotifySetpointsStop-request>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'groupMask)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'remainValidMillisecs)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'remainValidMillisecs)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'remainValidMillisecs)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'remainValidMillisecs)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<NotifySetpointsStop-request>)))
  "Returns string type for a service object of type '<NotifySetpointsStop-request>"
  "crazyswarm/NotifySetpointsStopRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'NotifySetpointsStop-request)))
  "Returns string type for a service object of type 'NotifySetpointsStop-request"
  "crazyswarm/NotifySetpointsStopRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<NotifySetpointsStop-request>)))
  "Returns md5sum for a message object of type '<NotifySetpointsStop-request>"
  "5e1e40fcf516d3883bc228627d3e1e43")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'NotifySetpointsStop-request)))
  "Returns md5sum for a message object of type 'NotifySetpointsStop-request"
  "5e1e40fcf516d3883bc228627d3e1e43")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<NotifySetpointsStop-request>)))
  "Returns full string definition for message of type '<NotifySetpointsStop-request>"
  (cl:format cl:nil "uint8 groupMask~%uint32 remainValidMillisecs~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'NotifySetpointsStop-request)))
  "Returns full string definition for message of type 'NotifySetpointsStop-request"
  (cl:format cl:nil "uint8 groupMask~%uint32 remainValidMillisecs~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <NotifySetpointsStop-request>))
  (cl:+ 0
     1
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <NotifySetpointsStop-request>))
  "Converts a ROS message object to a list"
  (cl:list 'NotifySetpointsStop-request
    (cl:cons ':groupMask (groupMask msg))
    (cl:cons ':remainValidMillisecs (remainValidMillisecs msg))
))
;//! \htmlinclude NotifySetpointsStop-response.msg.html

(cl:defclass <NotifySetpointsStop-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass NotifySetpointsStop-response (<NotifySetpointsStop-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <NotifySetpointsStop-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'NotifySetpointsStop-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name crazyswarm-srv:<NotifySetpointsStop-response> is deprecated: use crazyswarm-srv:NotifySetpointsStop-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <NotifySetpointsStop-response>) ostream)
  "Serializes a message object of type '<NotifySetpointsStop-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <NotifySetpointsStop-response>) istream)
  "Deserializes a message object of type '<NotifySetpointsStop-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<NotifySetpointsStop-response>)))
  "Returns string type for a service object of type '<NotifySetpointsStop-response>"
  "crazyswarm/NotifySetpointsStopResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'NotifySetpointsStop-response)))
  "Returns string type for a service object of type 'NotifySetpointsStop-response"
  "crazyswarm/NotifySetpointsStopResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<NotifySetpointsStop-response>)))
  "Returns md5sum for a message object of type '<NotifySetpointsStop-response>"
  "5e1e40fcf516d3883bc228627d3e1e43")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'NotifySetpointsStop-response)))
  "Returns md5sum for a message object of type 'NotifySetpointsStop-response"
  "5e1e40fcf516d3883bc228627d3e1e43")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<NotifySetpointsStop-response>)))
  "Returns full string definition for message of type '<NotifySetpointsStop-response>"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'NotifySetpointsStop-response)))
  "Returns full string definition for message of type 'NotifySetpointsStop-response"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <NotifySetpointsStop-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <NotifySetpointsStop-response>))
  "Converts a ROS message object to a list"
  (cl:list 'NotifySetpointsStop-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'NotifySetpointsStop)))
  'NotifySetpointsStop-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'NotifySetpointsStop)))
  'NotifySetpointsStop-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'NotifySetpointsStop)))
  "Returns string type for a service object of type '<NotifySetpointsStop>"
  "crazyswarm/NotifySetpointsStop")