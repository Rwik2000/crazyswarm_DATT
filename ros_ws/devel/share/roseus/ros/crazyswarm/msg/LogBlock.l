;; Auto-generated. Do not edit!


(when (boundp 'crazyswarm::LogBlock)
  (if (not (find-package "CRAZYSWARM"))
    (make-package "CRAZYSWARM"))
  (shadow 'LogBlock (find-package "CRAZYSWARM")))
(unless (find-package "CRAZYSWARM::LOGBLOCK")
  (make-package "CRAZYSWARM::LOGBLOCK"))

(in-package "ROS")
;;//! \htmlinclude LogBlock.msg.html


(defclass crazyswarm::LogBlock
  :super ros::object
  :slots (_topic_name _frequency _variables ))

(defmethod crazyswarm::LogBlock
  (:init
   (&key
    ((:topic_name __topic_name) "")
    ((:frequency __frequency) 0)
    ((:variables __variables) (let (r) (dotimes (i 0) (push "" r)) r))
    )
   (send-super :init)
   (setq _topic_name (string __topic_name))
   (setq _frequency (round __frequency))
   (setq _variables __variables)
   self)
  (:topic_name
   (&optional __topic_name)
   (if __topic_name (setq _topic_name __topic_name)) _topic_name)
  (:frequency
   (&optional __frequency)
   (if __frequency (setq _frequency __frequency)) _frequency)
  (:variables
   (&optional __variables)
   (if __variables (setq _variables __variables)) _variables)
  (:serialization-length
   ()
   (+
    ;; string _topic_name
    4 (length _topic_name)
    ;; int16 _frequency
    2
    ;; string[] _variables
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _variables)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _topic_name
       (write-long (length _topic_name) s) (princ _topic_name s)
     ;; int16 _frequency
       (write-word _frequency s)
     ;; string[] _variables
     (write-long (length _variables) s)
     (dolist (elem _variables)
       (write-long (length elem) s) (princ elem s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _topic_name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _topic_name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; int16 _frequency
     (setq _frequency (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; string[] _variables
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _variables (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _variables i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;;
   self)
  )

(setf (get crazyswarm::LogBlock :md5sum-) "d9325f33ff3a1ffc6b6c0323a9f9b181")
(setf (get crazyswarm::LogBlock :datatype-) "crazyswarm/LogBlock")
(setf (get crazyswarm::LogBlock :definition-)
      "string topic_name
int16 frequency
string[] variables

")



(provide :crazyswarm/LogBlock "d9325f33ff3a1ffc6b6c0323a9f9b181")


