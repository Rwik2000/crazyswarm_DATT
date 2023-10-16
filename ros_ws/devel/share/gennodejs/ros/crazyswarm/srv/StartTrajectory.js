// Auto-generated. Do not edit!

// (in-package crazyswarm.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class StartTrajectoryRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.groupMask = null;
      this.trajectoryId = null;
      this.timescale = null;
      this.reversed = null;
      this.relative = null;
    }
    else {
      if (initObj.hasOwnProperty('groupMask')) {
        this.groupMask = initObj.groupMask
      }
      else {
        this.groupMask = 0;
      }
      if (initObj.hasOwnProperty('trajectoryId')) {
        this.trajectoryId = initObj.trajectoryId
      }
      else {
        this.trajectoryId = 0;
      }
      if (initObj.hasOwnProperty('timescale')) {
        this.timescale = initObj.timescale
      }
      else {
        this.timescale = 0.0;
      }
      if (initObj.hasOwnProperty('reversed')) {
        this.reversed = initObj.reversed
      }
      else {
        this.reversed = false;
      }
      if (initObj.hasOwnProperty('relative')) {
        this.relative = initObj.relative
      }
      else {
        this.relative = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type StartTrajectoryRequest
    // Serialize message field [groupMask]
    bufferOffset = _serializer.uint8(obj.groupMask, buffer, bufferOffset);
    // Serialize message field [trajectoryId]
    bufferOffset = _serializer.uint8(obj.trajectoryId, buffer, bufferOffset);
    // Serialize message field [timescale]
    bufferOffset = _serializer.float32(obj.timescale, buffer, bufferOffset);
    // Serialize message field [reversed]
    bufferOffset = _serializer.bool(obj.reversed, buffer, bufferOffset);
    // Serialize message field [relative]
    bufferOffset = _serializer.bool(obj.relative, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type StartTrajectoryRequest
    let len;
    let data = new StartTrajectoryRequest(null);
    // Deserialize message field [groupMask]
    data.groupMask = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [trajectoryId]
    data.trajectoryId = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [timescale]
    data.timescale = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [reversed]
    data.reversed = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [relative]
    data.relative = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 8;
  }

  static datatype() {
    // Returns string type for a service object
    return 'crazyswarm/StartTrajectoryRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '74e2cf5224bc82fcc8d9c7dd3865d912';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint8 groupMask
    uint8 trajectoryId
    float32 timescale
    bool reversed
    bool relative
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new StartTrajectoryRequest(null);
    if (msg.groupMask !== undefined) {
      resolved.groupMask = msg.groupMask;
    }
    else {
      resolved.groupMask = 0
    }

    if (msg.trajectoryId !== undefined) {
      resolved.trajectoryId = msg.trajectoryId;
    }
    else {
      resolved.trajectoryId = 0
    }

    if (msg.timescale !== undefined) {
      resolved.timescale = msg.timescale;
    }
    else {
      resolved.timescale = 0.0
    }

    if (msg.reversed !== undefined) {
      resolved.reversed = msg.reversed;
    }
    else {
      resolved.reversed = false
    }

    if (msg.relative !== undefined) {
      resolved.relative = msg.relative;
    }
    else {
      resolved.relative = false
    }

    return resolved;
    }
};

class StartTrajectoryResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type StartTrajectoryResponse
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type StartTrajectoryResponse
    let len;
    let data = new StartTrajectoryResponse(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a service object
    return 'crazyswarm/StartTrajectoryResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'd41d8cd98f00b204e9800998ecf8427e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new StartTrajectoryResponse(null);
    return resolved;
    }
};

module.exports = {
  Request: StartTrajectoryRequest,
  Response: StartTrajectoryResponse,
  md5sum() { return '74e2cf5224bc82fcc8d9c7dd3865d912'; },
  datatype() { return 'crazyswarm/StartTrajectory'; }
};
