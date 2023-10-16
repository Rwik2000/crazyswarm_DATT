; Auto-generated. Do not edit!


(cl:in-package crazyswarm-srv)


;//! \htmlinclude Stop-request.msg.html

(cl:defclass <Stop-request> (roslisp-msg-protocol:ros-message)
  ((groupMask
    :reader groupMask
    :initarg :groupMask
    :type cl:fixnum
    :initform 0))
)

(cl:defclass Stop-request (<Stop-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Stop-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Stop-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name crazyswarm-srv:<Stop-request> is deprecated: use crazyswarm-srv:Stop-request instead.")))

(cl:ensure-generic-function 'groupMask-val :lambda-list '(m))
(cl:defmethod groupMask-val ((m <Stop-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader crazyswarm-srv:groupMask-val is deprecated.  Use crazyswarm-srv:groupMask instead.")
  (groupMask m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Stop-request>) ostream)
  "Serializes a message object of type '<Stop-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'groupMask)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Stop-request>) istream)
  "Deserializes a message object of type '<Stop-request>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'groupMask)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Stop-request>)))
  "Returns string type for a service object of type '<Stop-request>"
  "crazyswarm/StopRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Stop-request)))
  "Returns string type for a service object of type 'Stop-request"
  "crazyswarm/StopRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Stop-request>)))
  "Returns md5sum for a message object of type '<Stop-request>"
  "d44d7e9aa94d069ed5834dbd7329e1bb")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Stop-request)))
  "Returns md5sum for a message object of type 'Stop-request"
  "d44d7e9aa94d069ed5834dbd7329e1bb")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Stop-request>)))
  "Returns full string definition for message of type '<Stop-request>"
  (cl:format cl:nil "uint8 groupMask~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Stop-request)))
  "Returns full string definition for message of type 'Stop-request"
  (cl:format cl:nil "uint8 groupMask~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Stop-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Stop-request>))
  "Converts a ROS message object to a list"
  (cl:list 'Stop-request
    (cl:cons ':groupMask (groupMask msg))
))
;//! \htmlinclude Stop-response.msg.html

(cl:defclass <Stop-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass Stop-response (<Stop-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Stop-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Stop-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name crazyswarm-srv:<Stop-response> is deprecated: use crazyswarm-srv:Stop-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Stop-response>) ostream)
  "Serializes a message object of type '<Stop-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Stop-response>) istream)
  "Deserializes a message object of type '<Stop-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Stop-response>)))
  "Returns string type for a service object of type '<Stop-response>"
  "crazyswarm/StopResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Stop-response)))
  "Returns string type for a service object of type 'Stop-response"
  "crazyswarm/StopResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Stop-response>)))
  "Returns md5sum for a message object of type '<Stop-response>"
  "d44d7e9aa94d069ed5834dbd7329e1bb")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Stop-response)))
  "Returns md5sum for a message object of type 'Stop-response"
  "d44d7e9aa94d069ed5834dbd7329e1bb")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Stop-response>)))
  "Returns full string definition for message of type '<Stop-response>"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Stop-response)))
  "Returns full string definition for message of type 'Stop-response"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Stop-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Stop-response>))
  "Converts a ROS message object to a list"
  (cl:list 'Stop-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'Stop)))
  'Stop-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'Stop)))
  'Stop-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Stop)))
  "Returns string type for a service object of type '<Stop>"
  "crazyswarm/Stop")