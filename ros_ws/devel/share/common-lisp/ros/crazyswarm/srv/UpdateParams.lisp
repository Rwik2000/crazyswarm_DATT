; Auto-generated. Do not edit!


(cl:in-package crazyswarm-srv)


;//! \htmlinclude UpdateParams-request.msg.html

(cl:defclass <UpdateParams-request> (roslisp-msg-protocol:ros-message)
  ((params
    :reader params
    :initarg :params
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element "")))
)

(cl:defclass UpdateParams-request (<UpdateParams-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <UpdateParams-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'UpdateParams-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name crazyswarm-srv:<UpdateParams-request> is deprecated: use crazyswarm-srv:UpdateParams-request instead.")))

(cl:ensure-generic-function 'params-val :lambda-list '(m))
(cl:defmethod params-val ((m <UpdateParams-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader crazyswarm-srv:params-val is deprecated.  Use crazyswarm-srv:params instead.")
  (params m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <UpdateParams-request>) ostream)
  "Serializes a message object of type '<UpdateParams-request>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'params))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((__ros_str_len (cl:length ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) ele))
   (cl:slot-value msg 'params))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <UpdateParams-request>) istream)
  "Deserializes a message object of type '<UpdateParams-request>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'params) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'params)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<UpdateParams-request>)))
  "Returns string type for a service object of type '<UpdateParams-request>"
  "crazyswarm/UpdateParamsRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'UpdateParams-request)))
  "Returns string type for a service object of type 'UpdateParams-request"
  "crazyswarm/UpdateParamsRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<UpdateParams-request>)))
  "Returns md5sum for a message object of type '<UpdateParams-request>"
  "279e0627eb574ffe8968384218434f5f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'UpdateParams-request)))
  "Returns md5sum for a message object of type 'UpdateParams-request"
  "279e0627eb574ffe8968384218434f5f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<UpdateParams-request>)))
  "Returns full string definition for message of type '<UpdateParams-request>"
  (cl:format cl:nil "string[] params~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'UpdateParams-request)))
  "Returns full string definition for message of type 'UpdateParams-request"
  (cl:format cl:nil "string[] params~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <UpdateParams-request>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'params) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <UpdateParams-request>))
  "Converts a ROS message object to a list"
  (cl:list 'UpdateParams-request
    (cl:cons ':params (params msg))
))
;//! \htmlinclude UpdateParams-response.msg.html

(cl:defclass <UpdateParams-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass UpdateParams-response (<UpdateParams-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <UpdateParams-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'UpdateParams-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name crazyswarm-srv:<UpdateParams-response> is deprecated: use crazyswarm-srv:UpdateParams-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <UpdateParams-response>) ostream)
  "Serializes a message object of type '<UpdateParams-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <UpdateParams-response>) istream)
  "Deserializes a message object of type '<UpdateParams-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<UpdateParams-response>)))
  "Returns string type for a service object of type '<UpdateParams-response>"
  "crazyswarm/UpdateParamsResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'UpdateParams-response)))
  "Returns string type for a service object of type 'UpdateParams-response"
  "crazyswarm/UpdateParamsResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<UpdateParams-response>)))
  "Returns md5sum for a message object of type '<UpdateParams-response>"
  "279e0627eb574ffe8968384218434f5f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'UpdateParams-response)))
  "Returns md5sum for a message object of type 'UpdateParams-response"
  "279e0627eb574ffe8968384218434f5f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<UpdateParams-response>)))
  "Returns full string definition for message of type '<UpdateParams-response>"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'UpdateParams-response)))
  "Returns full string definition for message of type 'UpdateParams-response"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <UpdateParams-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <UpdateParams-response>))
  "Converts a ROS message object to a list"
  (cl:list 'UpdateParams-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'UpdateParams)))
  'UpdateParams-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'UpdateParams)))
  'UpdateParams-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'UpdateParams)))
  "Returns string type for a service object of type '<UpdateParams>"
  "crazyswarm/UpdateParams")