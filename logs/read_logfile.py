"""
Helper to decode binary logged sensor data from crazyflie2 with uSD-Card-Deck
"""
import argparse
from zlib import crc32
import struct
import numpy as np
import matplotlib.pyplot as plt
from collections import defaultdict

# extract null-terminated string
def _get_name(data, idx):
    endIdx = idx
    while data[endIdx] != 0:
        endIdx = endIdx + 1
    return data[idx:endIdx].decode("utf-8"), endIdx + 1

def decode(filename):
    # read file as binary
    with open(filename, 'rb') as f:
        data = f.read()

    # check magic header
    if data[0] != 0xBC:
        print("Unsupported format!")
        return

    # check CRC
    crc = crc32(data[0:-4])
    expected_crc, = struct.unpack('I', data[-4:])
    if crc != expected_crc:
        print("WARNING: CRC does not match!")

    # check version
    version, num_event_types = struct.unpack('HH', data[1:5])
    if version != 1 and version != 2:
        print("Unsupported version!", version)
        return

    result = dict()
    event_by_id = dict()

    # read header with data types
    idx = 5
    for _ in range(num_event_types):
        event_id, = struct.unpack('H', data[idx:idx+2])
        idx += 2
        event_name, idx = _get_name(data, idx)
        result[event_name] = dict()
        result[event_name]["timestamp"] = []
        num_variables, = struct.unpack('H', data[idx:idx+2])
        idx += 2
        fmtStr = "<"
        variables = []
        for _ in range(num_variables):
            var_name_and_type, idx = _get_name(data, idx)
            var_name = var_name_and_type[0:-3]
            var_type = var_name_and_type[-2]
            result[event_name][var_name] = []
            fmtStr += var_type
            variables.append(var_name)
        event_by_id[event_id] = {
            'name': event_name,
            'fmtStr': fmtStr,
            'numBytes': struct.calcsize(fmtStr),
            'variables': variables,
            }

    while idx < len(data) - 4:
        if version == 1:
            event_id, timestamp, = struct.unpack('<HI', data[idx:idx+6])
            idx += 6
        elif version == 2:
            event_id, timestamp, = struct.unpack('<HQ', data[idx:idx+10])
            timestamp = timestamp / 1000.0
            idx += 10
        event = event_by_id[event_id]
        fmtStr = event['fmtStr']
        eventData = struct.unpack(fmtStr, data[idx:idx+event['numBytes']])
        idx += event['numBytes']
        for v,d in zip(event['variables'], eventData):
            result[event['name']][v].append(d)
        result[event['name']]["timestamp"].append(timestamp)

    # remove keys that had no data
    for event_name in list(result.keys()):
        if len(result[event_name]['timestamp']) == 0:
            del result[event_name]

    # convert to numpy arrays
    for event_name in result.keys():
        for var_name in result[event_name]:
            result[event_name][var_name] = np.array(result[event_name][var_name])

    return result


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("filename")
    args = parser.parse_args()
    data = decode(args.filename)
    data = data['fixedFrequency']  

    ts = data['timestamp']
    
    plt.figure()
    plt.subplot(3, 1, 1)
    plt.plot(ts, data['ctrlMel.roll_vel_des'] * 180 / np.pi)
    plt.plot(ts, data['gyro.x'], color='red')
    plt.ylabel('Roll')
    plt.subplot(3, 1, 2)
    plt.plot(ts, data['ctrlMel.pitch_vel_des'] * 180/np.pi)
    plt.plot(ts, data['gyro.y'], color='red')
    plt.ylabel('Pitch')
    plt.subplot(3, 1, 3)
    plt.plot(ts, data['ctrlMel.des_yaw_vel'] * 180 / np.pi)
    plt.plot(ts, data['gyro.z'], color='red')
    plt.plot('Yaw')

    plt.suptitle('Ang velocity')

    # plt.figure()

    plt.show()

    # prefixes = defaultdict(list)
    # for name in data:
    #     if name == 'timestamp':
    #         continue
    #     name_prefix = name.split('.')
    #     if not name_prefix[0]:
    #         prefixes[name] = [(name, name)]
    #     else:
    #         prefixes[name_prefix[0]].append((name_prefix[0], name_prefix[1]))

    # j = 1
    # for group in prefixes:
    #     # plt.show()
    #     plt.figure(j)
    #     i = 1
    #     names = prefixes[group]
    #     n = len(names)
    #     # i = 0
    #     for prefix, suffix in names:
    #         plt.subplot(n, 1, i)
    #         if prefix == suffix:
    #             name = prefix
    #         else:
    #             name = f'{prefix}.{suffix}'
    #         i += 1
    #         print(name)
    #         plt.plot(ts, data[name])
    #         plt.suptitle(group)
    #         plt.ylabel(suffix)
    #     j+=1
    # plt.xlabel('t')
    
    # plt.show()
