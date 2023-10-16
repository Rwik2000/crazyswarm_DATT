;; Auto-generated. Do not edit!


(when (boundp 'crazyswarm::SetGroupMask)
  (if (not (find-package "CRAZYSWARM"))
    (make-package "CRAZYSWARM"))
  (shadow 'SetGroupMask (find-package "CRAZYSWARM")))
(unless (find-package "CRAZYSWARM::SETGROUPMASK")
  (make-package "CRAZYSWARM::SETGROUPMASK"))
(unless (find-package "CRAZYSWARM::SETGROUPMASKREQUEST")
  (make-package "CRAZYSWARM::SETGROUPMASKREQUEST"))
(unless (find-package "CRAZYSWARM::SETGROUPMASKRESPONSE")
  (make-package "CRAZYSWARM::SETGROUPMASKRESPONSE"))

(in-package "ROS")





(defclass crazyswarm::SetGroupMaskRequest
  :super ros::object
  :slots (_groupMask ))

(defmethod crazyswarm::SetGroupMaskRequest
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

(defclass crazyswarm::SetGroupMaskResponse
  :super ros::object
  :slots ())

(defmethod crazyswarm::SetGroupMaskResponse
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

(defclass crazyswarm::SetGroupMask
  :super ros::object
  :slots ())

(setf (get crazyswarm::SetGroupMask :md5sum-) "d44d7e9aa94d069ed5834dbd7329e1bb")
(setf (get crazyswarm::SetGroupMask :datatype-) "crazyswarm/SetGroupMask")
(setf (get crazyswarm::SetGroupMask :request) crazyswarm::SetGroupMaskRequest)
(setf (get crazyswarm::SetGroupMask :response) crazyswarm::SetGroupMaskResponse)

(defmethod crazyswarm::SetGroupMaskRequest
  (:response () (instance crazyswarm::SetGroupMaskResponse :init)))

(setf (get crazyswarm::SetGroupMaskRequest :md5sum-) "d44d7e9aa94d069ed5834dbd7329e1bb")
(setf (get crazyswarm::SetGroupMaskRequest :datatype-) "crazyswarm/SetGroupMaskRequest")
(setf (get crazyswarm::SetGroupMaskRequest :definition-)
      "uint8 groupMask
---

")

(setf (get crazyswarm::SetGroupMaskResponse :md5sum-) "d44d7e9aa94d069ed5834dbd7329e1bb")
(setf (get crazyswarm::SetGroupMaskResponse :datatype-) "crazyswarm/SetGroupMaskResponse")
(setf (get crazyswarm::SetGroupMaskResponse :definition-)
      "uint8 groupMask
---

")



(provide :crazyswarm/SetGroupMask "d44d7e9aa94d069ed5834dbd7329e1bb")


