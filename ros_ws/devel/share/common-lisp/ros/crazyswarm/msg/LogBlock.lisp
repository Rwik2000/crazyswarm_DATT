; Auto-generated. Do not edit!


(cl:in-package crazyswarm-msg)


;//! \htmlinclude LogBlock.msg.html

(cl:defclass <LogBlock> (roslisp-msg-protocol:ros-message)
  ((topic_name
    :reader topic_name
    :initarg :topic_name
    :type cl:string
    :initform "")
   (frequency
    :reader frequency
    :initarg :frequency
    :type cl:fixnum
    :initform 0)
   (variables
    :reader variables
    :initarg :variables
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element "")))
)

(cl:defclass LogBlock (<LogBlock>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LogBlock>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LogBlock)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name crazyswarm-msg:<LogBlock> is deprecated: use crazyswarm-msg:LogBlock instead.")))

(cl:ensure-generic-function 'topic_name-val :lambda-list '(m))
(cl:defmethod topic_name-val ((m <LogBlock>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader crazyswarm-msg:topic_name-val is deprecated.  Use crazyswarm-msg:topic_name instead.")
  (topic_name m))

(cl:ensure-generic-function 'frequency-val :lambda-list '(m))
(cl:defmethod frequency-val ((m <LogBlock>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader crazyswarm-msg:frequency-val is deprecated.  Use crazyswarm-msg:frequency instead.")
  (frequency m))

(cl:ensure-generic-function 'variables-val :lambda-list '(m))
(cl:defmethod variables-val ((m <LogBlock>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader crazyswarm-msg:variables-val is deprecated.  Use crazyswarm-msg:variables instead.")
  (variables m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LogBlock>) ostream)
  "Serializes a message object of type '<LogBlock>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'topic_name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'topic_name))
  (cl:let* ((signed (cl:slot-value msg 'frequency)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'variables))))
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
   (cl:slot-value msg 'variables))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LogBlock>) istream)
  "Deserializes a message object of type '<LogBlock>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'topic_name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'topic_name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'frequency) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'variables) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'variables)))
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LogBlock>)))
  "Returns string type for a message object of type '<LogBlock>"
  "crazyswarm/LogBlock")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LogBlock)))
  "Returns string type for a message object of type 'LogBlock"
  "crazyswarm/LogBlock")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LogBlock>)))
  "Returns md5sum for a message object of type '<LogBlock>"
  "d9325f33ff3a1ffc6b6c0323a9f9b181")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LogBlock)))
  "Returns md5sum for a message object of type 'LogBlock"
  "d9325f33ff3a1ffc6b6c0323a9f9b181")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LogBlock>)))
  "Returns full string definition for message of type '<LogBlock>"
  (cl:format cl:nil "string topic_name~%int16 frequency~%string[] variables~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LogBlock)))
  "Returns full string definition for message of type 'LogBlock"
  (cl:format cl:nil "string topic_name~%int16 frequency~%string[] variables~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LogBlock>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'topic_name))
     2
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'variables) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LogBlock>))
  "Converts a ROS message object to a list"
  (cl:list 'LogBlock
    (cl:cons ':topic_name (topic_name msg))
    (cl:cons ':frequency (frequency msg))
    (cl:cons ':variables (variables msg))
))
