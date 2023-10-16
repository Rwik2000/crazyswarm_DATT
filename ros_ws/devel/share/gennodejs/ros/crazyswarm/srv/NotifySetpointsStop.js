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

class NotifySetpointsStopRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.groupMask = null;
      this.remainValidMillisecs = null;
    }
    else {
      if (initObj.hasOwnProperty('groupMask')) {
        this.groupMask = initObj.groupMask
      }
      else {
        this.groupMask = 0;
      }
      if (initObj.hasOwnProperty('remainValidMillisecs')) {
        this.remainValidMillisecs = initObj.remainValidMillisecs
      }
      else {
        this.remainValidMillisecs = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type NotifySetpointsStopRequest
    // Serialize message field [groupMask]
    bufferOffset = _serializer.uint8(obj.groupMask, buffer, bufferOffset);
    // Serialize message field [remainValidMillisecs]
    bufferOffset = _serializer.uint32(obj.remainValidMillisecs, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type NotifySetpointsStopRequest
    let len;
    let data = new NotifySetpointsStopRequest(null);
    // Deserialize message field [groupMask]
    data.groupMask = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [remainValidMillisecs]
    data.remainValidMillisecs = _deserializer.uint32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 5;
  }

  static datatype() {
    // Returns string type for a service object
    return 'crazyswarm/NotifySetpointsStopRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '5e1e40fcf516d3883bc228627d3e1e43';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint8 groupMask
    uint32 remainValidMillisecs
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new NotifySetpointsStopRequest(null);
    if (msg.groupMask !== undefined) {
      resolved.groupMask = msg.groupMask;
    }
    else {
      resolved.groupMask = 0
    }

    if (msg.remainValidMillisecs !== undefined) {
      resolved.remainValidMillisecs = msg.remainValidMillisecs;
    }
    else {
      resolved.remainValidMillisecs = 0
    }

    return resolved;
    }
};

class NotifySetpointsStopResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type NotifySetpointsStopResponse
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type NotifySetpointsStopResponse
    let len;
    let data = new NotifySetpointsStopResponse(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a service object
    return 'crazyswarm/NotifySetpointsStopResponse';
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
    const resolved = new NotifySetpointsStopResponse(null);
    return resolved;
    }
};

module.exports = {
  Request: NotifySetpointsStopRequest,
  Response: NotifySetpointsStopResponse,
  md5sum() { return '5e1e40fcf516d3883bc228627d3e1e43'; },
  datatype() { return 'crazyswarm/NotifySetpointsStop'; }
};
