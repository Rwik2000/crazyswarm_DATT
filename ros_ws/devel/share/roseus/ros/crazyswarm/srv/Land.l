;; Auto-generated. Do not edit!


(when (boundp 'crazyswarm::Land)
  (if (not (find-package "CRAZYSWARM"))
    (make-package "CRAZYSWARM"))
  (shadow 'Land (find-package "CRAZYSWARM")))
(unless (find-package "CRAZYSWARM::LAND")
  (make-package "CRAZYSWARM::LAND"))
(unless (find-package "CRAZYSWARM::LANDREQUEST")
  (make-package "CRAZYSWARM::LANDREQUEST"))
(unless (find-package "CRAZYSWARM::LANDRESPONSE")
  (make-package "CRAZYSWARM::LANDRESPONSE"))

(in-package "ROS")





(defclass crazyswarm::LandRequest
  :super ros::object
  :slots (_groupMask _height _duration ))

(defmethod crazyswarm::LandRequest
  (:init
   (&key
    ((:groupMask __groupMask) 0)
    ((:height __height) 0.0)
    ((:duration __duration) (instance ros::time :init))
    )
   (send-super :init)
   (setq _groupMask (round __groupMask))
   (setq _height (float __height))
   (setq _duration __duration)
   self)
  (:groupMask
   (&optional __groupMask)
   (if __groupMask (setq _groupMask __groupMask)) _groupMask)
  (:height
   (&optional __height)
   (if __height (setq _height __height)) _height)
  (:duration
   (&optional __duration)
   (if __duration (setq _duration __duration)) _duration)
  (:serialization-length
   ()
   (+
    ;; uint8 _groupMask
    1
    ;; float32 _height
    4
    ;; duration _duration
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _groupMask
       (write-byte _groupMask s)
     ;; float32 _height
       (sys::poke _height (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; duration _duration
       (write-long (send _duration :sec) s) (write-long (send _duration :nsec) s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _groupMask
     (setq _groupMask (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32 _height
     (setq _height (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; duration _duration
     (send _duration :sec (sys::peek buf ptr- :integer)) (incf ptr- 4)  (send _duration :nsec (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(defclass crazyswarm::LandResponse
  :super ros::object
  :slots ())

(defmethod crazyswarm::LandResponse
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

(defclass crazyswarm::Land
  :super ros::object
  :slots ())

(setf (get crazyswarm::Land :md5sum-) "b665b6c83a196e4774268cc26329b159")
(setf (get crazyswarm::Land :datatype-) "crazyswarm/Land")
(setf (get crazyswarm::Land :request) crazyswarm::LandRequest)
(setf (get crazyswarm::Land :response) crazyswarm::LandResponse)

(defmethod crazyswarm::LandRequest
  (:response () (instance crazyswarm::LandResponse :init)))

(setf (get crazyswarm::LandRequest :md5sum-) "b665b6c83a196e4774268cc26329b159")
(setf (get crazyswarm::LandRequest :datatype-) "crazyswarm/LandRequest")
(setf (get crazyswarm::LandRequest :definition-)
      "uint8 groupMask
float32 height
duration duration
---

")

(setf (get crazyswarm::LandResponse :md5sum-) "b665b6c83a196e4774268cc26329b159")
(setf (get crazyswarm::LandResponse :datatype-) "crazyswarm/LandResponse")
(setf (get crazyswarm::LandResponse :definition-)
      "uint8 groupMask
float32 height
duration duration
---

")



(provide :crazyswarm/Land "b665b6c83a196e4774268cc26329b159")


