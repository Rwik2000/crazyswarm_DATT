
"use strict";

let NotifySetpointsStop = require('./NotifySetpointsStop.js')
let UploadTrajectory = require('./UploadTrajectory.js')
let UpdateParams = require('./UpdateParams.js')
let Takeoff = require('./Takeoff.js')
let GoTo = require('./GoTo.js')
let SetGroupMask = require('./SetGroupMask.js')
let StartTrajectory = require('./StartTrajectory.js')
let Stop = require('./Stop.js')
let Land = require('./Land.js')

module.exports = {
  NotifySetpointsStop: NotifySetpointsStop,
  UploadTrajectory: UploadTrajectory,
  UpdateParams: UpdateParams,
  Takeoff: Takeoff,
  GoTo: GoTo,
  SetGroupMask: SetGroupMask,
  StartTrajectory: StartTrajectory,
  Stop: Stop,
  Land: Land,
};
