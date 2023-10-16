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

class TrajectoryPolynomialPiece {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.poly_x = null;
      this.poly_y = null;
      this.poly_z = null;
      this.poly_yaw = null;
      this.duration = null;
    }
    else {
      if (initObj.hasOwnProperty('poly_x')) {
        this.poly_x = initObj.poly_x
      }
      else {
        this.poly_x = [];
      }
      if (initObj.hasOwnProperty('poly_y')) {
        this.poly_y = initObj.poly_y
      }
      else {
        this.poly_y = [];
      }
      if (initObj.hasOwnProperty('poly_z')) {
        this.poly_z = initObj.poly_z
      }
      else {
        this.poly_z = [];
      }
      if (initObj.hasOwnProperty('poly_yaw')) {
        this.poly_yaw = initObj.poly_yaw
      }
      else {
        this.poly_yaw = [];
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
    // Serializes a message object of type TrajectoryPolynomialPiece
    // Serialize message field [poly_x]
    bufferOffset = _arraySerializer.float32(obj.poly_x, buffer, bufferOffset, null);
    // Serialize message field [poly_y]
    bufferOffset = _arraySerializer.float32(obj.poly_y, buffer, bufferOffset, null);
    // Serialize message field [poly_z]
    bufferOffset = _arraySerializer.float32(obj.poly_z, buffer, bufferOffset, null);
    // Serialize message field [poly_yaw]
    bufferOffset = _arraySerializer.float32(obj.poly_yaw, buffer, bufferOffset, null);
    // Serialize message field [duration]
    bufferOffset = _serializer.duration(obj.duration, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type TrajectoryPolynomialPiece
    let len;
    let data = new TrajectoryPolynomialPiece(null);
    // Deserialize message field [poly_x]
    data.poly_x = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [poly_y]
    data.poly_y = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [poly_z]
    data.poly_z = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [poly_yaw]
    data.poly_yaw = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [duration]
    data.duration = _deserializer.duration(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 4 * object.poly_x.length;
    length += 4 * object.poly_y.length;
    length += 4 * object.poly_z.length;
    length += 4 * object.poly_yaw.length;
    return length + 24;
  }

  static datatype() {
    // Returns string type for a message object
    return 'crazyswarm/TrajectoryPolynomialPiece';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '9099d336831f8a28304456aacb0d75e8';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    #
    
    float32[] poly_x
    float32[] poly_y
    float32[] poly_z
    float32[] poly_yaw
    duration duration
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new TrajectoryPolynomialPiece(null);
    if (msg.poly_x !== undefined) {
      resolved.poly_x = msg.poly_x;
    }
    else {
      resolved.poly_x = []
    }

    if (msg.poly_y !== undefined) {
      resolved.poly_y = msg.poly_y;
    }
    else {
      resolved.poly_y = []
    }

    if (msg.poly_z !== undefined) {
      resolved.poly_z = msg.poly_z;
    }
    else {
      resolved.poly_z = []
    }

    if (msg.poly_yaw !== undefined) {
      resolved.poly_yaw = msg.poly_yaw;
    }
    else {
      resolved.poly_yaw = []
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

module.exports = TrajectoryPolynomialPiece;
