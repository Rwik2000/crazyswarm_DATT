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

class TakeoffRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.groupMask = null;
      this.height = null;
      this.duration = null;
    }
    else {
      if (initObj.hasOwnProperty('groupMask')) {
        this.groupMask = initObj.groupMask
      }
      else {
        this.groupMask = 0;
      }
      if (initObj.hasOwnProperty('height')) {
        this.height = initObj.height
      }
      else {
        this.height = 0.0;
      }
      if (initObj.hasOwnProperty('duration')) {
        this.duration = initObj.duration
      }
      else {
        this.duration = {secs: 0, nsecs: 0};
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type TakeoffRequest
    // Serialize message field [groupMask]
    bufferOffset = _serializer.uint8(obj.groupMask, buffer, bufferOffset);
    // Serialize message field [height]
    bufferOffset = _serializer.float32(obj.height, buffer, bufferOffset);
    // Serialize message field [duration]
    bufferOffset = _serializer.duration(obj.duration, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type TakeoffRequest
    let len;
    let data = new TakeoffRequest(null);
    // Deserialize message field [groupMask]
    data.groupMask = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [height]
    data.height = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [duration]
    data.duration = _deserializer.duration(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 13;
  }

  static datatype() {
    // Returns string type for a service object
    return 'crazyswarm/TakeoffRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'b665b6c83a196e4774268cc26329b159';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint8 groupMask
    float32 height
    duration duration
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new TakeoffRequest(null);
    if (msg.groupMask !== undefined) {
      resolved.groupMask = msg.groupMask;
    }
    else {
      resolved.groupMask = 0
    }

    if (msg.height !== undefined) {
      resolved.height = msg.height;
    }
    else {
      resolved.height = 0.0
    }

    if (msg.duration !== undefined) {
      resolved.duration = msg.duration;
    }
    else {
      resolved.duration = {secs: 0, nsecs: 0}
    }

    return resolved;
    }
};

class TakeoffResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type TakeoffResponse
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type TakeoffResponse
    let len;
    let data = new TakeoffResponse(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a service object
    return 'crazyswarm/TakeoffResponse';
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
    const resolved = new TakeoffResponse(null);
    return resolved;
    }
};

module.exports = {
  Request: TakeoffRequest,
  Response: TakeoffResponse,
  md5sum() { return 'b665b6c83a196e4774268cc26329b159'; },
  datatype() { return 'crazyswarm/Takeoff'; }
};
