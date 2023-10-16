; Auto-generated. Do not edit!


(cl:in-package crazyswarm-srv)


;//! \htmlinclude SetGroupMask-request.msg.html

(cl:defclass <SetGroupMask-request> (roslisp-msg-protocol:ros-message)
  ((groupMask
    :reader groupMask
    :initarg :groupMask
    :type cl:fixnum
    :initform 0))
)

(cl:defclass SetGroupMask-request (<SetGroupMask-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetGroupMask-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetGroupMask-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name crazyswarm-srv:<SetGroupMask-request> is deprecated: use crazyswarm-srv:SetGroupMask-request instead.")))

(cl:ensure-generic-function 'groupMask-val :lambda-list '(m))
(cl:defmethod groupMask-val ((m <SetGroupMask-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader crazyswarm-srv:groupMask-val is deprecated.  Use crazyswarm-srv:groupMask instead.")
  (groupMask m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetGroupMask-request>) ostream)
  "Serializes a message object of type '<SetGroupMask-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'groupMask)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetGroupMask-request>) istream)
  "Deserializes a message object of type '<SetGroupMask-request>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'groupMask)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetGroupMask-request>)))
  "Returns string type for a service object of type '<SetGroupMask-request>"
  "crazyswarm/SetGroupMaskRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetGroupMask-request)))
  "Returns string type for a service object of type 'SetGroupMask-request"
  "crazyswarm/SetGroupMaskRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetGroupMask-request>)))
  "Returns md5sum for a message object of type '<SetGroupMask-request>"
  "d44d7e9aa94d069ed5834dbd7329e1bb")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetGroupMask-request)))
  "Returns md5sum for a message object of type 'SetGroupMask-request"
  "d44d7e9aa94d069ed5834dbd7329e1bb")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetGroupMask-request>)))
  "Returns full string definition for message of type '<SetGroupMask-request>"
  (cl:format cl:nil "uint8 groupMask~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetGroupMask-request)))
  "Returns full string definition for message of type 'SetGroupMask-request"
  (cl:format cl:nil "uint8 groupMask~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetGroupMask-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetGroupMask-request>))
  "Converts a ROS message object to a list"
  (cl:list 'SetGroupMask-request
    (cl:cons ':groupMask (groupMask msg))
))
;//! \htmlinclude SetGroupMask-response.msg.html

(cl:defclass <SetGroupMask-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass SetGroupMask-response (<SetGroupMask-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetGroupMask-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetGroupMask-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name crazyswarm-srv:<SetGroupMask-response> is deprecated: use crazyswarm-srv:SetGroupMask-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetGroupMask-response>) ostream)
  "Serializes a message object of type '<SetGroupMask-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetGroupMask-response>) istream)
  "Deserializes a message object of type '<SetGroupMask-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetGroupMask-response>)))
  "Returns string type for a service object of type '<SetGroupMask-response>"
  "crazyswarm/SetGroupMaskResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetGroupMask-response)))
  "Returns string type for a service object of type 'SetGroupMask-response"
  "crazyswarm/SetGroupMaskResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetGroupMask-response>)))
  "Returns md5sum for a message object of type '<SetGroupMask-response>"
  "d44d7e9aa94d069ed5834dbd7329e1bb")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetGroupMask-response)))
  "Returns md5sum for a message object of type 'SetGroupMask-response"
  "d44d7e9aa94d069ed5834dbd7329e1bb")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetGroupMask-response>)))
  "Returns full string definition for message of type '<SetGroupMask-response>"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetGroupMask-response)))
  "Returns full string definition for message of type 'SetGroupMask-response"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetGroupMask-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetGroupMask-response>))
  "Converts a ROS message object to a list"
  (cl:list 'SetGroupMask-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'SetGroupMask)))
  'SetGroupMask-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'SetGroupMask)))
  'SetGroupMask-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetGroupMask)))
  "Returns string type for a service object of type '<SetGroupMask>"
  "crazyswarm/SetGroupMask")