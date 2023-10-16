;; Auto-generated. Do not edit!


(when (boundp 'crazyswarm::UpdateParams)
  (if (not (find-package "CRAZYSWARM"))
    (make-package "CRAZYSWARM"))
  (shadow 'UpdateParams (find-package "CRAZYSWARM")))
(unless (find-package "CRAZYSWARM::UPDATEPARAMS")
  (make-package "CRAZYSWARM::UPDATEPARAMS"))
(unless (find-package "CRAZYSWARM::UPDATEPARAMSREQUEST")
  (make-package "CRAZYSWARM::UPDATEPARAMSREQUEST"))
(unless (find-package "CRAZYSWARM::UPDATEPARAMSRESPONSE")
  (make-package "CRAZYSWARM::UPDATEPARAMSRESPONSE"))

(in-package "ROS")





(defclass crazyswarm::UpdateParamsRequest
  :super ros::object
  :slots (_params ))

(defmethod crazyswarm::UpdateParamsRequest
  (:init
   (&key
    ((:params __params) (let (r) (dotimes (i 0) (push "" r)) r))
    )
   (send-super :init)
   (setq _params __params)
   self)
  (:params
   (&optional __params)
   (if __params (setq _params __params)) _params)
  (:serialization-length
   ()
   (+
    ;; string[] _params
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _params)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string[] _params
     (write-long (length _params) s)
     (dolist (elem _params)
       (write-long (length elem) s) (princ elem s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string[] _params
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _params (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _params i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;;
   self)
  )

(defclass crazyswarm::UpdateParamsResponse
  :super ros::object
  :slots ())

(defmethod crazyswarm::UpdateParamsResponse
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

(defclass crazyswarm::UpdateParams
  :super ros::object
  :slots ())

(setf (get crazyswarm::UpdateParams :md5sum-) "279e0627eb574ffe8968384218434f5f")
(setf (get crazyswarm::UpdateParams :datatype-) "crazyswarm/UpdateParams")
(setf (get crazyswarm::UpdateParams :request) crazyswarm::UpdateParamsRequest)
(setf (get crazyswarm::UpdateParams :response) crazyswarm::UpdateParamsResponse)

(defmethod crazyswarm::UpdateParamsRequest
  (:response () (instance crazyswarm::UpdateParamsResponse :init)))

(setf (get crazyswarm::UpdateParamsRequest :md5sum-) "279e0627eb574ffe8968384218434f5f")
(setf (get crazyswarm::UpdateParamsRequest :datatype-) "crazyswarm/UpdateParamsRequest")
(setf (get crazyswarm::UpdateParamsRequest :definition-)
      "string[] params
---

")

(setf (get crazyswarm::UpdateParamsResponse :md5sum-) "279e0627eb574ffe8968384218434f5f")
(setf (get crazyswarm::UpdateParamsResponse :datatype-) "crazyswarm/UpdateParamsResponse")
(setf (get crazyswarm::UpdateParamsResponse :definition-)
      "string[] params
---

")



(provide :crazyswarm/UpdateParams "279e0627eb574ffe8968384218434f5f")


