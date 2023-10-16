; Auto-generated. Do not edit!


(cl:in-package crazyswarm-srv)


;//! \htmlinclude UploadTrajectory-request.msg.html

(cl:defclass <UploadTrajectory-request> (roslisp-msg-protocol:ros-message)
  ((trajectoryId
    :reader trajectoryId
    :initarg :trajectoryId
    :type cl:fixnum
    :initform 0)
   (pieceOffset
    :reader pieceOffset
    :initarg :pieceOffset
    :type cl:integer
    :initform 0)
   (pieces
    :reader pieces
    :initarg :pieces
    :type (cl:vector crazyswarm-msg:TrajectoryPolynomialPiece)
   :initform (cl:make-array 0 :element-type 'crazyswarm-msg:TrajectoryPolynomialPiece :initial-element (cl:make-instance 'crazyswarm-msg:TrajectoryPolynomialPiece))))
)

(cl:defclass UploadTrajectory-request (<UploadTrajectory-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <UploadTrajectory-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'UploadTrajectory-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name crazyswarm-srv:<UploadTrajectory-request> is deprecated: use crazyswarm-srv:UploadTrajectory-request instead.")))

(cl:ensure-generic-function 'trajectoryId-val :lambda-list '(m))
(cl:defmethod trajectoryId-val ((m <UploadTrajectory-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader crazyswarm-srv:trajectoryId-val is deprecated.  Use crazyswarm-srv:trajectoryId instead.")
  (trajectoryId m))

(cl:ensure-generic-function 'pieceOffset-val :lambda-list '(m))
(cl:defmethod pieceOffset-val ((m <UploadTrajectory-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader crazyswarm-srv:pieceOffset-val is deprecated.  Use crazyswarm-srv:pieceOffset instead.")
  (pieceOffset m))

(cl:ensure-generic-function 'pieces-val :lambda-list '(m))
(cl:defmethod pieces-val ((m <UploadTrajectory-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader crazyswarm-srv:pieces-val is deprecated.  Use crazyswarm-srv:pieces instead.")
  (pieces m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <UploadTrajectory-request>) ostream)
  "Serializes a message object of type '<UploadTrajectory-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'trajectoryId)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'pieceOffset)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'pieceOffset)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'pieceOffset)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'pieceOffset)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'pieces))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'pieces))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <UploadTrajectory-request>) istream)
  "Deserializes a message object of type '<UploadTrajectory-request>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'trajectoryId)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'pieceOffset)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'pieceOffset)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'pieceOffset)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'pieceOffset)) (cl:read-byte istream))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'pieces) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'pieces)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'crazyswarm-msg:TrajectoryPolynomialPiece))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<UploadTrajectory-request>)))
  "Returns string type for a service object of type '<UploadTrajectory-request>"
  "crazyswarm/UploadTrajectoryRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'UploadTrajectory-request)))
  "Returns string type for a service object of type 'UploadTrajectory-request"
  "crazyswarm/UploadTrajectoryRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<UploadTrajectory-request>)))
  "Returns md5sum for a message object of type '<UploadTrajectory-request>"
  "becd7733dfdc3d0c93a9064ba651cf17")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'UploadTrajectory-request)))
  "Returns md5sum for a message object of type 'UploadTrajectory-request"
  "becd7733dfdc3d0c93a9064ba651cf17")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<UploadTrajectory-request>)))
  "Returns full string definition for message of type '<UploadTrajectory-request>"
  (cl:format cl:nil "uint8 trajectoryId~%uint32 pieceOffset~%TrajectoryPolynomialPiece[] pieces~%~%================================================================================~%MSG: crazyswarm/TrajectoryPolynomialPiece~%#~%~%float32[] poly_x~%float32[] poly_y~%float32[] poly_z~%float32[] poly_yaw~%duration duration~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'UploadTrajectory-request)))
  "Returns full string definition for message of type 'UploadTrajectory-request"
  (cl:format cl:nil "uint8 trajectoryId~%uint32 pieceOffset~%TrajectoryPolynomialPiece[] pieces~%~%================================================================================~%MSG: crazyswarm/TrajectoryPolynomialPiece~%#~%~%float32[] poly_x~%float32[] poly_y~%float32[] poly_z~%float32[] poly_yaw~%duration duration~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <UploadTrajectory-request>))
  (cl:+ 0
     1
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'pieces) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <UploadTrajectory-request>))
  "Converts a ROS message object to a list"
  (cl:list 'UploadTrajectory-request
    (cl:cons ':trajectoryId (trajectoryId msg))
    (cl:cons ':pieceOffset (pieceOffset msg))
    (cl:cons ':pieces (pieces msg))
))
;//! \htmlinclude UploadTrajectory-response.msg.html

(cl:defclass <UploadTrajectory-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass UploadTrajectory-response (<UploadTrajectory-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <UploadTrajectory-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'UploadTrajectory-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name crazyswarm-srv:<UploadTrajectory-response> is deprecated: use crazyswarm-srv:UploadTrajectory-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <UploadTrajectory-response>) ostream)
  "Serializes a message object of type '<UploadTrajectory-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <UploadTrajectory-response>) istream)
  "Deserializes a message object of type '<UploadTrajectory-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<UploadTrajectory-response>)))
  "Returns string type for a service object of type '<UploadTrajectory-response>"
  "crazyswarm/UploadTrajectoryResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'UploadTrajectory-response)))
  "Returns string type for a service object of type 'UploadTrajectory-response"
  "crazyswarm/UploadTrajectoryResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<UploadTrajectory-response>)))
  "Returns md5sum for a message object of type '<UploadTrajectory-response>"
  "becd7733dfdc3d0c93a9064ba651cf17")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'UploadTrajectory-response)))
  "Returns md5sum for a message object of type 'UploadTrajectory-response"
  "becd7733dfdc3d0c93a9064ba651cf17")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<UploadTrajectory-response>)))
  "Returns full string definition for message of type '<UploadTrajectory-response>"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'UploadTrajectory-response)))
  "Returns full string definition for message of type 'UploadTrajectory-response"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <UploadTrajectory-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <UploadTrajectory-response>))
  "Converts a ROS message object to a list"
  (cl:list 'UploadTrajectory-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'UploadTrajectory)))
  'UploadTrajectory-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'UploadTrajectory)))
  'UploadTrajectory-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'UploadTrajectory)))
  "Returns string type for a service object of type '<UploadTrajectory>"
  "crazyswarm/UploadTrajectory")