// Auto-generated. Do not edit!

// (in-package crazyswarm.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let TrajectoryPolynomialPiece = require('../msg/TrajectoryPolynomialPiece.js');

//-----------------------------------------------------------


//-----------------------------------------------------------

class UploadTrajectoryRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.trajectoryId = null;
      this.pieceOffset = null;
      this.pieces = null;
    }
    else {
      if (initObj.hasOwnProperty('trajectoryId')) {
        this.trajectoryId = initObj.trajectoryId
      }
      else {
        this.trajectoryId = 0;
      }
      if (initObj.hasOwnProperty('pieceOffset')) {
        this.pieceOffset = initObj.pieceOffset
      }
      else {
        this.pieceOffset = 0;
      }
      if (initObj.hasOwnProperty('pieces')) {
        this.pieces = initObj.pieces
      }
      else {
        this.pieces = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type UploadTrajectoryRequest
    // Serialize message field [trajectoryId]
    bufferOffset = _serializer.uint8(obj.trajectoryId, buffer, bufferOffset);
    // Serialize message field [pieceOffset]
    bufferOffset = _serializer.uint32(obj.pieceOffset, buffer, bufferOffset);
    // Serialize message field [pieces]
    // Serialize the length for message field [pieces]
    bufferOffset = _serializer.uint32(obj.pieces.length, buffer, bufferOffset);
    obj.pieces.forEach((val) => {
      bufferOffset = TrajectoryPolynomialPiece.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type UploadTrajectoryRequest
    let len;
    let data = new UploadTrajectoryRequest(null);
    // Deserialize message field [trajectoryId]
    data.trajectoryId = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [pieceOffset]
    data.pieceOffset = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [pieces]
    // Deserialize array length for message field [pieces]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.pieces = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.pieces[i] = TrajectoryPolynomialPiece.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.pieces.forEach((val) => {
      length += TrajectoryPolynomialPiece.getMessageSize(val);
    });
    return length + 9;
  }

  static datatype() {
    // Returns string type for a service object
    return 'crazyswarm/UploadTrajectoryRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'becd7733dfdc3d0c93a9064ba651cf17';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint8 trajectoryId
    uint32 pieceOffset
    TrajectoryPolynomialPiece[] pieces
    
    ================================================================================
    MSG: crazyswarm/TrajectoryPolynomialPiece
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
    const resolved = new UploadTrajectoryRequest(null);
    if (msg.trajectoryId !== undefined) {
      resolved.trajectoryId = msg.trajectoryId;
    }
    else {
      resolved.trajectoryId = 0
    }

    if (msg.pieceOffset !== undefined) {
      resolved.pieceOffset = msg.pieceOffset;
    }
    else {
      resolved.pieceOffset = 0
    }

    if (msg.pieces !== undefined) {
      resolved.pieces = new Array(msg.pieces.length);
      for (let i = 0; i < resolved.pieces.length; ++i) {
        resolved.pieces[i] = TrajectoryPolynomialPiece.Resolve(msg.pieces[i]);
      }
    }
    else {
      resolved.pieces = []
    }

    return resolved;
    }
};

class UploadTrajectoryResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type UploadTrajectoryResponse
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type UploadTrajectoryResponse
    let len;
    let data = new UploadTrajectoryResponse(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a service object
    return 'crazyswarm/UploadTrajectoryResponse';
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
    const resolved = new UploadTrajectoryResponse(null);
    return resolved;
    }
};

module.exports = {
  Request: UploadTrajectoryRequest,
  Response: UploadTrajectoryResponse,
  md5sum() { return 'becd7733dfdc3d0c93a9064ba651cf17'; },
  datatype() { return 'crazyswarm/UploadTrajectory'; }
};
