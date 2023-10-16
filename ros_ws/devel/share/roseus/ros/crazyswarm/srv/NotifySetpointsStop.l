;; Auto-generated. Do not edit!


(when (boundp 'crazyswarm::NotifySetpointsStop)
  (if (not (find-package "CRAZYSWARM"))
    (make-package "CRAZYSWARM"))
  (shadow 'NotifySetpointsStop (find-package "CRAZYSWARM")))
(unless (find-package "CRAZYSWARM::NOTIFYSETPOINTSSTOP")
  (make-package "CRAZYSWARM::NOTIFYSETPOINTSSTOP"))
(unless (find-package "CRAZYSWARM::NOTIFYSETPOINTSSTOPREQUEST")
  (make-package "CRAZYSWARM::NOTIFYSETPOINTSSTOPREQUEST"))
(unless (find-package "CRAZYSWARM::NOTIFYSETPOINTSSTOPRESPONSE")
  (make-package "CRAZYSWARM::NOTIFYSETPOINTSSTOPRESPONSE"))

(in-package "ROS")





(defclass crazyswarm::NotifySetpointsStopRequest
  :super ros::object
  :slots (_groupMask _remainValidMillisecs ))

(defmethod crazyswarm::NotifySetpointsStopRequest
  (:init
   (&key
    ((:groupMask __groupMask) 0)
    ((:remainValidMillisecs __remainValidMillisecs) 0)
    )
   (send-super :init)
   (setq _groupMask (round __groupMask))
   (setq _remainValidMillisecs (round __remainValidMillisecs))
   self)
  (:groupMask
   (&optional __groupMask)
   (if __groupMask (setq _groupMask __groupMask)) _groupMask)
  (:remainValidMillisecs
   (&optional __remainValidMillisecs)
   (if __remainValidMillisecs (setq _remainValidMillisecs __remainValidMillisecs)) _remainValidMillisecs)
  (:serialization-length
   ()
   (+
    ;; uint8 _groupMask
    1
    ;; uint32 _remainValidMillisecs
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _groupMask
       (write-byte _groupMask s)
     ;; uint32 _remainValidMillisecs
       (write-long _remainValidMillisecs s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _groupMask
     (setq _groupMask (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint32 _remainValidMillisecs
     (setq _remainValidMillisecs (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(defclass crazyswarm::NotifySetpointsStopResponse
  :super ros::object
  :slots ())

(defmethod crazyswarm::NotifySetpointsStopResponse
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

(defclass crazyswarm::NotifySetpointsStop
  :super ros::object
  :slots ())

(setf (get crazyswarm::NotifySetpointsStop :md5sum-) "5e1e40fcf516d3883bc228627d3e1e43")
(setf (get crazyswarm::NotifySetpointsStop :datatype-) "crazyswarm/NotifySetpointsStop")
(setf (get crazyswarm::NotifySetpointsStop :request) crazyswarm::NotifySetpointsStopRequest)
(setf (get crazyswarm::NotifySetpointsStop :response) crazyswarm::NotifySetpointsStopResponse)

(defmethod crazyswarm::NotifySetpointsStopRequest
  (:response () (instance crazyswarm::NotifySetpointsStopResponse :init)))

(setf (get crazyswarm::NotifySetpointsStopRequest :md5sum-) "5e1e40fcf516d3883bc228627d3e1e43")
(setf (get crazyswarm::NotifySetpointsStopRequest :datatype-) "crazyswarm/NotifySetpointsStopRequest")
(setf (get crazyswarm::NotifySetpointsStopRequest :definition-)
      "uint8 groupMask
uint32 remainValidMillisecs
---

")

(setf (get crazyswarm::NotifySetpointsStopResponse :md5sum-) "5e1e40fcf516d3883bc228627d3e1e43")
(setf (get crazyswarm::NotifySetpointsStopResponse :datatype-) "crazyswarm/NotifySetpointsStopResponse")
(setf (get crazyswarm::NotifySetpointsStopResponse :definition-)
      "uint8 groupMask
uint32 remainValidMillisecs
---

")



(provide :crazyswarm/NotifySetpointsStop "5e1e40fcf516d3883bc228627d3e1e43")


