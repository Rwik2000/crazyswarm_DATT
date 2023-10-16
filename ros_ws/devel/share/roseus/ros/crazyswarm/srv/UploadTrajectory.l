;; Auto-generated. Do not edit!


(when (boundp 'crazyswarm::UploadTrajectory)
  (if (not (find-package "CRAZYSWARM"))
    (make-package "CRAZYSWARM"))
  (shadow 'UploadTrajectory (find-package "CRAZYSWARM")))
(unless (find-package "CRAZYSWARM::UPLOADTRAJECTORY")
  (make-package "CRAZYSWARM::UPLOADTRAJECTORY"))
(unless (find-package "CRAZYSWARM::UPLOADTRAJECTORYREQUEST")
  (make-package "CRAZYSWARM::UPLOADTRAJECTORYREQUEST"))
(unless (find-package "CRAZYSWARM::UPLOADTRAJECTORYRESPONSE")
  (make-package "CRAZYSWARM::UPLOADTRAJECTORYRESPONSE"))

(in-package "ROS")





(defclass crazyswarm::UploadTrajectoryRequest
  :super ros::object
  :slots (_trajectoryId _pieceOffset _pieces ))

(defmethod crazyswarm::UploadTrajectoryRequest
  (:init
   (&key
    ((:trajectoryId __trajectoryId) 0)
    ((:pieceOffset __pieceOffset) 0)
    ((:pieces __pieces) ())
    )
   (send-super :init)
   (setq _trajectoryId (round __trajectoryId))
   (setq _pieceOffset (round __pieceOffset))
   (setq _pieces __pieces)
   self)
  (:trajectoryId
   (&optional __trajectoryId)
   (if __trajectoryId (setq _trajectoryId __trajectoryId)) _trajectoryId)
  (:pieceOffset
   (&optional __pieceOffset)
   (if __pieceOffset (setq _pieceOffset __pieceOffset)) _pieceOffset)
  (:pieces
   (&rest __pieces)
   (if (keywordp (car __pieces))
       (send* _pieces __pieces)
     (progn
       (if __pieces (setq _pieces (car __pieces)))
       _pieces)))
  (:serialization-length
   ()
   (+
    ;; uint8 _trajectoryId
    1
    ;; uint32 _pieceOffset
    4
    ;; crazyswarm/TrajectoryPolynomialPiece[] _pieces
    (apply #'+ (send-all _pieces :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _trajectoryId
       (write-byte _trajectoryId s)
     ;; uint32 _pieceOffset
       (write-long _pieceOffset s)
     ;; crazyswarm/TrajectoryPolynomialPiece[] _pieces
     (write-long (length _pieces) s)
     (dolist (elem _pieces)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _trajectoryId
     (setq _trajectoryId (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint32 _pieceOffset
     (setq _pieceOffset (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; crazyswarm/TrajectoryPolynomialPiece[] _pieces
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _pieces (let (r) (dotimes (i n) (push (instance crazyswarm::TrajectoryPolynomialPiece :init) r)) r))
     (dolist (elem- _pieces)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(defclass crazyswarm::UploadTrajectoryResponse
  :super ros::object
  :slots ())

(defmethod crazyswarm::UploadTrajectoryResponse
  (:init
   (&key
    )
   (send-super :init)
   self)
  (:serialization-length
   ()
   (+
    0
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;;
   self)
  )

(defclass crazyswarm::UploadTrajectory
  :super ros::object
  :slots ())

(setf (get crazyswarm::UploadTrajectory :md5sum-) "becd7733dfdc3d0c93a9064ba651cf17")
(setf (get crazyswarm::UploadTrajectory :datatype-) "crazyswarm/UploadTrajectory")
(setf (get crazyswarm::UploadTrajectory :request) crazyswarm::UploadTrajectoryRequest)
(setf (get crazyswarm::UploadTrajectory :response) crazyswarm::UploadTrajectoryResponse)

(defmethod crazyswarm::UploadTrajectoryRequest
  (:response () (instance crazyswarm::UploadTrajectoryResponse :init)))

(setf (get crazyswarm::UploadTrajectoryRequest :md5sum-) "becd7733dfdc3d0c93a9064ba651cf17")
(setf (get crazyswarm::UploadTrajectoryRequest :datatype-) "crazyswarm/UploadTrajectoryRequest")
(setf (get crazyswarm::UploadTrajectoryRequest :definition-)
      "uint8 trajectoryId
uint32 pieceOffset
TrajectoryPolynomialPiece[] pieces

================================================================================
MSG: crazyswarm/TrajectoryPolynomialPiece
#

float32[] poly_x
float32[] poly_y
float32[] poly_z
float32[] poly_yaw
---

")

(setf (get crazyswarm::UploadTrajectoryResponse :md5sum-) "becd7733dfdc3d0c93a9064ba651cf17")
(setf (get crazyswarm::UploadTrajectoryResponse :datatype-) "crazyswarm/UploadTrajectoryResponse")
(setf (get crazyswarm::UploadTrajectoryResponse :definition-)
      "uint8 trajectoryId
uint32 pieceOffset
TrajectoryPolynomialPiece[] pieces

================================================================================
MSG: crazyswarm/TrajectoryPolynomialPiece
#

float32[] poly_x
float32[] poly_y
float32[] poly_z
float32[] poly_yaw
---

")



(provide :crazyswarm/UploadTrajectory "becd7733dfdc3d0c93a9064ba651cf17")


