
(cl:in-package :asdf)

(defsystem "crazyswarm-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :crazyswarm-msg
               :geometry_msgs-msg
)
  :components ((:file "_package")
    (:file "GoTo" :depends-on ("_package_GoTo"))
    (:file "_package_GoTo" :depends-on ("_package"))
    (:file "Land" :depends-on ("_package_Land"))
    (:file "_package_Land" :depends-on ("_package"))
    (:file "NotifySetpointsStop" :depends-on ("_package_NotifySetpointsStop"))
    (:file "_package_NotifySetpointsStop" :depends-on ("_package"))
    (:file "SetGroupMask" :depends-on ("_package_SetGroupMask"))
    (:file "_package_SetGroupMask" :depends-on ("_package"))
    (:file "StartTrajectory" :depends-on ("_package_StartTrajectory"))
    (:file "_package_StartTrajectory" :depends-on ("_package"))
    (:file "Stop" :depends-on ("_package_Stop"))
    (:file "_package_Stop" :depends-on ("_package"))
    (:file "Takeoff" :depends-on ("_package_Takeoff"))
    (:file "_package_Takeoff" :depends-on ("_package"))
    (:file "UpdateParams" :depends-on ("_package_UpdateParams"))
    (:file "_package_UpdateParams" :depends-on ("_package"))
    (:file "UploadTrajectory" :depends-on ("_package_UploadTrajectory"))
    (:file "_package_UploadTrajectory" :depends-on ("_package"))
  ))