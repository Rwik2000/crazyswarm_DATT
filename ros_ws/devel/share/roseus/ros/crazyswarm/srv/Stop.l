;; Auto-generated. Do not edit!


(when (boundp 'crazyswarm::Stop)
  (if (not (find-package "CRAZYSWARM"))
    (make-package "CRAZYSWARM"))
  (shadow 'Stop (find-package "CRAZYSWARM")))
(unless (find-package "CRAZYSWARM::STOP")
  (make-package "CRAZYSWARM::STOP"))
(unless (find-package "CRAZYSWARM::STOPREQUEST")
  (make-package "CRAZYSWARM::STOPREQUEST"))
(unless (find-package "CRAZYSWARM::STOPRESPONSE")
  (make-package "CRAZYSWARM::STOPRESPONSE"))

(in-package "ROS")





(defclass crazyswarm::StopRequest
  :super ros::object
  :slots (_groupMask ))

(defmethod crazyswarm::StopRequest
  (:init
   (&key
    ((:groupMask __groupMask) 0)
    )
   (send-super :init)
   (setq _groupMask (round __groupMask))
   self)
  (:groupMask
   (&optional __groupMask)
   (if __groupMask (setq _groupMask __groupMask)) _groupMask)
  (:serialization-length
   ()
   (+
    ;; uint8 _groupMask
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _groupMask
       (write-byte _groupMask s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _groupMask
     (setq _groupMask (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(defclass crazyswarm::StopResponse
  :super ros::object
  :slots ())

(defmethod crazyswarm::StopResponse
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

(defclass crazyswarm::Stop
  :super ros::object
  :slots ())

(setf (get crazyswarm::Stop :md5sum-) "d44d7e9aa94d069ed5834dbd7329e1bb")
(setf (get crazyswarm::Stop :datatype-) "crazyswarm/Stop")
(setf (get crazyswarm::Stop :request) crazyswarm::StopRequest)
(setf (get crazyswarm::Stop :response) crazyswarm::StopResponse)

(defmethod crazyswarm::StopRequest
  (:response () (instance crazyswarm::StopResponse :init)))

(setf (get crazyswarm::StopRequest :md5sum-) "d44d7e9aa94d069ed5834dbd7329e1bb")
(setf (get crazyswarm::StopRequest :datatype-) "crazyswarm/StopRequest")
(setf (get crazyswarm::StopRequest :definition-)
      "uint8 groupMask
---

")

(setf (get crazyswarm::StopResponse :md5sum-) "d44d7e9aa94d069ed5834dbd7329e1bb")
(setf (get crazyswarm::StopResponse :datatype-) "crazyswarm/StopResponse")
(setf (get crazyswarm::StopResponse :definition-)
      "uint8 groupMask
---

")



(provide :crazyswarm/Stop "d44d7e9aa94d069ed5834dbd7329e1bb")


