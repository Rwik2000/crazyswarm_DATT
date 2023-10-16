# -*- coding: utf-8 -*-
"""
example on how to plot decoded sensor data from crazyflie
@author: jsschell
"""
import CF_functions as cff
import matplotlib.pyplot as plt
import re
import argparse
import numpy as np
from scipy.spatial.transform import Rotation as R

parser = argparse.ArgumentParser()
parser.add_argument("filename")
args = parser.parse_args()

# decode binary log data
logData = cff.decode(args.filename)

# set window background to white
plt.rcParams['figure.facecolor'] = 'w'
    
# number of columns and rows for suplot
plotCols = 1;
plotRows = 1;

# let's see which keys exists in current data set
keys = ""
for k, v in logData.items():
    keys += k

# get plot config from user
# plotGyro = 0
# if re.search('gyro', keys):
#     inStr = input("plot gyro data? ([Y]es / [n]o): ")
#     if ((re.search('^[Yy]', inStr)) or (inStr == '')):
#         plotGyro = 1
#         plotRows += 1

# plotAccel = 0
# if re.search('acc', keys):
#     inStr = input("plot accel data? ([Y]es / [n]o): ")
#     if ((re.search('^[Yy]', inStr)) or (inStr == '')):
#         plotAccel = 1
#         plotRows += 1

# plotMag = 0
# if re.search('mag', keys):
#     inStr = input("plot magnetometer data? ([Y]es / [n]o): ")
#     if ((re.search('^[Yy]', inStr)) or (inStr == '')):
#         plotMag = 1
#         plotRows += 1

# plotBaro = 0
# if re.search('baro', keys):
#     inStr = input("plot barometer data? ([Y]es / [n]o): ")
#     if ((re.search('^[Yy]', inStr)) or (inStr == '')):
#         plotBaro = 1
#         plotRows += 1

# plotCtrl = 0
# if re.search('ctrltarget', keys):
#     inStr = input("plot control data? ([Y]es / [n]o): ")
#     if ((re.search('^[Yy]', inStr)) or (inStr == '')):
#         plotCtrl = 1
#         plotRows += 1

# plotStab = 0
# if re.search('stabilizer', keys):
#     inStr = input("plot stabilizer data? ([Y]es / [n]o): ")
#     if ((re.search('^[Yy]', inStr)) or (inStr == '')):
#         plotStab = 1
#         plotRows += 1

# plotRwik = 0
# if re.search('ctrlRwik', keys):
#     inStr = input("plot Rwik data? ([Y]es / [n]o): ")
#     if ((re.search('^[Yy]', inStr)) or (inStr == '')):
#         plotRwik = 1
#         plotRows += 1
    
# # current plot for simple subplot usage
# plotCurrent = 0;

# new figure
plt.figure(0)

ax = plt.subplot(3, 1, 1)
plt.plot(logData['tick'], logData['ctrlRwik.angVel_x'])
plt.plot(logData['tick'], logData['gyro.x'], color='red')
plt.ylabel('Roll')
plt.subplot(3, 1, 2, sharex=ax)
plt.plot(logData['tick'], logData['ctrlRwik.angVel_y'])
plt.plot(logData['tick'], logData['gyro.y'], color='red')
plt.ylabel('Pitch')
plt.subplot(3, 1, 3, sharex=ax)
plt.plot(logData['tick'], logData['ctrlRwik.angVel_z'], label='Cmd ang vel (deg/s)')
plt.plot(logData['tick'], logData['gyro.z'], color='red', label='Measured ang vel (deg/s)')
plt.ylabel('Yaw')
plt.suptitle('Angular Velocity (deg/s)')
plt.legend()

plt.figure(1)
ax1 = plt.subplot(3, 1, 1)
x = logData['ctrlRwik.quat_x']
y = logData['ctrlRwik.quat_y']
z = logData['ctrlRwik.quat_z']
w = logData['ctrlRwik.quat_w']


quat = np.c_[x, y, z, w]

norms = np.linalg.norm(quat, axis=1)
zero_norms = norms == 0

quat = quat[~zero_norms]
ts = logData['tick']
ts = ts[~zero_norms]

rot = R.from_quat(quat)
eulers = rot.as_euler('ZXY', degrees=True)
plt.plot(ts, eulers[:, 1], color='red')
try:
    plt.plot(ts, logData['ctrlRwik.rot_des_x'][~zero_norms], color='green')
except:
    pass
plt.plot(ts, logData['ctrlRwik.angVel_x'][~zero_norms])
plt.ylabel('X')

plt.subplot(3, 1, 2, sharex=ax1)
plt.plot(ts, eulers[:, 2], color='red')
try:
    plt.plot(ts, logData['ctrlRwik.rot_des_y'][~zero_norms], color='green')
except:
    pass
plt.plot(ts, logData['ctrlRwik.angVel_y'][~zero_norms])
plt.ylabel('Y')

plt.subplot(3, 1, 3, sharex=ax1)
plt.plot(ts, eulers[:, 0], color='red', label='Euler angle (deg)')
plt.plot(ts, logData['ctrlRwik.angVel_z'][~zero_norms], label='Cmd Ang Vel (deg/s)')
plt.ylabel('Z')
plt.legend()

save_data = {
    'ts' : ts,
    'ang_x' : logData['ctrlRwik.angVel_x'][~zero_norms],
    'ang_y' : logData['ctrlRwik.angVel_y'][~zero_norms],
    'ang_z' : logData['ctrlRwik.angVel_z'][~zero_norms],
}

np.savez("delay_model", **save_data)

plt.suptitle('Orientation and Des ang vel')

plt.figure(2)
ax2 = plt.subplot(3, 1, 1)
try:
    plt.plot(logData['tick'], logData['ctrlRwik.state_x'])
except:
    pass
try:
    plt.plot(logData['tick'], logData['ctrlRwik.ref_x'], color='green')
except:
    pass

plt.subplot(3, 1, 2, sharex=ax2)
try:
    plt.plot(logData['tick'], logData['ctrlRwik.state_y'])
except:
    pass
try:
    plt.plot(logData['tick'], logData['ctrlRwik.ref_y'], color='green')
except:
    pass

plt.subplot(3, 1, 3, sharex=ax2)
try:
    plt.plot(logData['tick'], logData['ctrlRwik.state_z'])
except:
    pass
try:
    plt.plot(logData['tick'], logData['ctrlRwik.ref_z'], color='green')
except:
    pass
plt.suptitle('position')

plt.figure(3)
try:
    plt.plot(logData['tick'], logData['ctrlRwik.cmd_z_acc'])
except:
    pass
plt.title('Cmd z acc')

try:
    plt.figure(4)
    ax4 = plt.subplot(3, 1, 1)
    plt.plot(ts, logData['gyro.x'][~zero_norms], color='red')
    plt.plot(ts, logData['ctrlRwik.angVel_x'][~zero_norms])
    plt.plot(ts, logData['ctrlRwik.cmd_roll'][~zero_norms]/100)
    plt.ylabel('X')

    plt.subplot(3, 1, 2, sharex=ax4)
    plt.plot(ts, logData['gyro.y'][~zero_norms], color='red')
    plt.plot(ts, logData['ctrlRwik.angVel_y'][~zero_norms])
    plt.plot(ts, logData['ctrlRwik.cmd_pitch'][~zero_norms]/100)
    plt.ylabel('Y')

    plt.subplot(3, 1, 3, sharex=ax4)
    plt.plot(ts, logData['gyro.z'][~zero_norms], color='red', label='Measured ang vel (deg/s)')
    plt.plot(ts, logData['ctrlRwik.angVel_z'][~zero_norms], label='Cmd Ang Vel (deg/s)')
    plt.plot(ts, logData['ctrlRwik.cmd_yaw'][~zero_norms]/100, label='outputted cmds')
    plt.ylabel('Z')
    plt.legend()
except:
    pass
# plt.figure(3)
# plt.subplot(3, 1, 1)
# plt.plot(logData['tick'], logData['acc.x'])
# plt.subplot(3, 1, 2)
# plt.plot(logData['tick'], logData['acc.y'])
# plt.subplot(3, 1, 3)
# plt.plot(logData['tick'], logData['acc.z'])


plt.show()

# if plotGyro:
#     plotCurrent += 1
#     plt.figure()
#     plt.plot(logData['tick'], logData['gyro.x'], '-', label='X')
#     plt.plot(logData['tick'], logData['ctrlRwik.angVel_x'], '-', label='roll')
#     plt.xlabel('RTOS Ticks')
#     plt.ylabel('Gyroscope [°/s]')
#     plt.legend(loc=9, ncol=3, borderaxespad=0.)

# if plotGyro:
#     plotCurrent += 1
#     plt.figure()
#     plt.plot(logData['tick'], logData['gyro.y'], '-', label='Y')
#     plt.plot(logData['tick'], logData['ctrlRwik.angVel_y'], '-', label='pitch')
#     plt.xlabel('RTOS Ticks')
#     plt.ylabel('Gyroscope [°/s]')
#     plt.legend(loc=9, ncol=3, borderaxespad=0.)

# if plotGyro:
#     plotCurrent += 1
#     plt.figure()
#     plt.plot(logData['tick'], logData['gyro.z'], '-', label='Z')
#     plt.plot(logData['tick'], logData['ctrlRwik.angVel_z'], '-', label='yaw')
#     plt.xlabel('RTOS Ticks')
#     plt.ylabel('Gyroscope [°/s]')
#     plt.legend(loc=9, ncol=3, borderaxespad=0.)
 
# if plotAccel:
#     plotCurrent += 1
#     plt.subplot(plotRows, plotCols, plotCurrent)
#     plt.plot(logData['tick'], logData['acc.x'], '-', label='X')
#     plt.plot(logData['tick'], logData['acc.y'], '-', label='Y')
#     plt.plot(logData['tick'], logData['acc.z'], '-', label='Z')
#     plt.xlabel('RTOS Ticks')
#     plt.ylabel('Accelerometer [g]')
#     plt.legend(loc=9, ncol=3, borderaxespad=0.)
 

# if plotMag:
#     plotCurrent += 1
#     plt.subplot(plotRows, plotCols, plotCurrent)
#     plt.plot(logData['tick'], logData['mag.x'], '-', label='X')
#     plt.plot(logData['tick'], logData['mag.y'], '-', label='Y')
#     plt.plot(logData['tick'], logData['mag.z'], '-', label='Z')
#     plt.xlabel('RTOS Ticks')
#     plt.ylabel('Magnetometer')
#     plt.legend(loc=9, ncol=3, borderaxespad=0.)

# if plotBaro:
#     plotCurrent += 1
#     plt.subplot(plotRows, plotCols, plotCurrent)
#     plt.plot(logData['tick'], logData['baro.pressure'], '-')
#     plt.xlabel('RTOS Ticks')
#     plt.ylabel('Pressure [hPa]')
    
#     plotCurrent += 1
#     plt.subplot(plotRows, plotCols, plotCurrent)
#     plt.plot(logData['tick'], logData['baro.temp'], '-')
#     plt.xlabel('RTOS Ticks')
#     plt.ylabel('Temperature [degC]')

# if plotCtrl:
#     plotCurrent += 1
#     plt.subplot(plotRows, plotCols, plotCurrent)
#     plt.plot(logData['tick'], logData['ctrltarget.roll'], '-', label='roll')
#     plt.plot(logData['tick'], logData['ctrltarget.pitch'], '-', label='pitch')
#     plt.plot(logData['tick'], logData['ctrltarget.yaw'], '-', label='yaw')
#     plt.xlabel('RTOS Ticks')
#     plt.ylabel('Control')
#     plt.legend(loc=9, ncol=3, borderaxespad=0.)

# if plotStab:
#     plotCurrent += 1
#     plt.subplot(plotRows, plotCols, plotCurrent)
#     plt.plot(logData['tick'], logData['stabilizer.roll'], '-', label='roll')
#     plt.plot(logData['tick'], logData['stabilizer.pitch'], '-', label='pitch')
#     plt.plot(logData['tick'], logData['stabilizer.yaw'], '-', label='yaw')
#     plt.plot(logData['tick'], logData['stabilizer.thrust'], '-', label='thrust')
#     plt.xlabel('RTOS Ticks')
#     plt.ylabel('Stabilizer')
#     plt.legend(loc=9, ncol=4, borderaxespad=0.)

# if plotRwik:
#     plotCurrent += 1
#     plt.subplot(plotRows, plotCols, plotCurrent)
#     plt.plot(logData['tick'], logData['ctrlRwik.angVel_x'], '-', label='roll')
#     plt.plot(logData['tick'], logData['ctrlRwik.angVel_y'], '-', label='pitch')
#     plt.plot(logData['tick'], logData['ctrlRwik.angVel_z'], '-', label='yaw')
#     plt.xlabel('RTOS Ticks')
#     plt.ylabel('Rwik')
#     plt.legend(loc=9, ncol=4, borderaxespad=0.)

# plt.show()