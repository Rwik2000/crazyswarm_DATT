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

class StopRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.groupMask = null;
    }
    else {
      if (initObj.hasOwnProperty('groupMask')) {
        this.groupMask = initObj.groupMask
      }
      else {
        this.groupMask = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type StopRequest
    // Serialize message field [groupMask]
    bufferOffset = _serializer.uint8(obj.groupMask, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type StopRequest
    let len;
    let data = new StopRequest(null);
    // Deserialize message field [groupMask]
    data.groupMask = _deserializer.uint8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'crazyswarm/StopRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'd44d7e9aa94d069ed5834dbd7329e1bb';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint8 groupMask
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new StopRequest(null);
    if (msg.groupMask !== undefined) {
      resolved.groupMask = msg.groupMask;
    }
    else {
      resolved.groupMask = 0
    }

    return resolved;
    }
};

class StopResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type StopResponse
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type StopResponse
    let len;
    let data = new StopResponse(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a service object
    return 'crazyswarm/StopResponse';
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
    const resolved = new StopResponse(null);
    return resolved;
    }
};

module.exports = {
  Request: StopRequest,
  Response: StopResponse,
  md5sum() { return 'd44d7e9aa94d069ed5834dbd7329e1bb'; },
  datatype() { return 'crazyswarm/Stop'; }
};
