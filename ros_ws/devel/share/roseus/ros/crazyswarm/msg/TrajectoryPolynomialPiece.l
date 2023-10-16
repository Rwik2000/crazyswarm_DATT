;; Auto-generated. Do not edit!


(when (boundp 'crazyswarm::TrajectoryPolynomialPiece)
  (if (not (find-package "CRAZYSWARM"))
    (make-package "CRAZYSWARM"))
  (shadow 'TrajectoryPolynomialPiece (find-package "CRAZYSWARM")))
(unless (find-package "CRAZYSWARM::TRAJECTORYPOLYNOMIALPIECE")
  (make-package "CRAZYSWARM::TRAJECTORYPOLYNOMIALPIECE"))

(in-package "ROS")
;;//! \htmlinclude TrajectoryPolynomialPiece.msg.html


(defclass crazyswarm::TrajectoryPolynomialPiece
  :super ros::object
  :slots (_poly_x _poly_y _poly_z _poly_yaw _duration ))

(defmethod crazyswarm::TrajectoryPolynomialPiece
  (:init
   (&key
    ((:poly_x __poly_x) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:poly_y __poly_y) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:poly_z __poly_z) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:poly_yaw __poly_yaw) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:duration __duration) (instance ros::time :init))
    )
   (send-super :init)
   (setq _poly_x __poly_x)
   (setq _poly_y __poly_y)
   (setq _poly_z __poly_z)
   (setq _poly_yaw __poly_yaw)
   (setq _duration __duration)
   self)
  (:poly_x
   (&optional __poly_x)
   (if __poly_x (setq _poly_x __poly_x)) _poly_x)
  (:poly_y
   (&optional __poly_y)
   (if __poly_y (setq _poly_y __poly_y)) _poly_y)
  (:poly_z
   (&optional __poly_z)
   (if __poly_z (setq _poly_z __poly_z)) _poly_z)
  (:poly_yaw
   (&optional __poly_yaw)
   (if __poly_yaw (setq _poly_yaw __poly_yaw)) _poly_yaw)
  (:duration
   (&optional __duration)
   (if __duration (setq _duration __duration)) _duration)
  (:serialization-length
   ()
   (+
    ;; float32[] _poly_x
    (* 4    (length _poly_x)) 4
    ;; float32[] _poly_y
    (* 4    (length _poly_y)) 4
    ;; float32[] _poly_z
    (* 4    (length _poly_z)) 4
    ;; float32[] _poly_yaw
    (* 4    (length _poly_yaw)) 4
    ;; duration _duration
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32[] _poly_x
     (write-long (length _poly_x) s)
     (dotimes (i (length _poly_x))
       (sys::poke (elt _poly_x i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _poly_y
     (write-long (length _poly_y) s)
     (dotimes (i (length _poly_y))
       (sys::poke (elt _poly_y i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _poly_z
     (write-long (length _poly_z) s)
     (dotimes (i (length _poly_z))
       (sys::poke (elt _poly_z i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _poly_yaw
     (write-long (length _poly_yaw) s)
     (dotimes (i (length _poly_yaw))
       (sys::poke (elt _poly_yaw i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; duration _duration
       (write-long (send _duration :sec) s) (write-long (send _duration :nsec) s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32[] _poly_x
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _poly_x (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _poly_x i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _poly_y
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _poly_y (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _poly_y i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _poly_z
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _poly_z (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _poly_z i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _poly_yaw
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _poly_yaw (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _poly_yaw i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; duration _duration
     (send _duration :sec (sys::peek buf ptr- :integer)) (incf ptr- 4)  (send _duration :nsec (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get crazyswarm::TrajectoryPolynomialPiece :md5sum-) "9099d336831f8a28304456aacb0d75e8")
(setf (get crazyswarm::TrajectoryPolynomialPiece :datatype-) "crazyswarm/TrajectoryPolynomialPiece")
(setf (get crazyswarm::TrajectoryPolynomialPiece :definition-)
      "#

float32[] poly_x
float32[] poly_y
float32[] poly_z
float32[] poly_yaw
duration duration
")



(provide :crazyswarm/TrajectoryPolynomialPiece "9099d336831f8a28304456aacb0d75e8")


