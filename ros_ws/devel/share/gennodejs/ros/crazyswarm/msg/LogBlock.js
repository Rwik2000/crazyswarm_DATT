// Auto-generated. Do not edit!

// (in-package crazyswarm.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class LogBlock {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.topic_name = null;
      this.frequency = null;
      this.variables = null;
    }
    else {
      if (initObj.hasOwnProperty('topic_name')) {
        this.topic_name = initObj.topic_name
      }
      else {
        this.topic_name = '';
      }
      if (initObj.hasOwnProperty('frequency')) {
        this.frequency = initObj.frequency
      }
      else {
        this.frequency = 0;
      }
      if (initObj.hasOwnProperty('variables')) {
        this.variables = initObj.variables
      }
      else {
        this.variables = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type LogBlock
    // Serialize message field [topic_name]
    bufferOffset = _serializer.string(obj.topic_name, buffer, bufferOffset);
    // Serialize message field [frequency]
    bufferOffset = _serializer.int16(obj.frequency, buffer, bufferOffset);
    // Serialize message field [variables]
    bufferOffset = _arraySerializer.string(obj.variables, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type LogBlock
    let len;
    let data = new LogBlock(null);
    // Deserialize message field [topic_name]
    data.topic_name = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [frequency]
    data.frequency = _deserializer.int16(buffer, bufferOffset);
    // Deserialize message field [variables]
    data.variables = _arrayDeserializer.string(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.topic_name);
    object.variables.forEach((val) => {
      length += 4 + _getByteLength(val);
    });
    return length + 10;
  }

  static datatype() {
    // Returns string type for a message object
    return 'crazyswarm/LogBlock';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'd9325f33ff3a1ffc6b6c0323a9f9b181';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string topic_name
    int16 frequency
    string[] variables
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new LogBlock(null);
    if (msg.topic_name !== undefined) {
      resolved.topic_name = msg.topic_name;
    }
    else {
      resolved.topic_name = ''
    }

    if (msg.frequency !== undefined) {
      resolved.frequency = msg.frequency;
    }
    else {
      resolved.frequency = 0
    }

    if (msg.variables !== undefined) {
      resolved.variables = msg.variables;
    }
    else {
      resolved.variables = []
    }

    return resolved;
    }
};

module.exports = LogBlock;
