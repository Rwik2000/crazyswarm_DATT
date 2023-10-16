import numpy as np
import argparse
import matplotlib.pyplot as plt
def smoothing(arr,length=4):
    # arr= arr*1.3
    arr = np.copy(arr)
    for i in range(length,len(arr)):
        arr[i] = np.mean(arr[i-length+1:i+1])
        # print(scale*(arr[i] - arr[i-1])/(ts[i] - ts[i-1]))
        # arr[i] = arr[i] + scale*(arr[i] - arr[i-1])/(ts[i] - ts[i-1])
    
    # # a = arr[1:] - arr[:-1]
    # b = ts[1:] - ts[:-1]
    # c = arr[1:]/b
    # c = np.insert(c, 0, 0)
    
    return arr

def plot_npz(filename):
    saved_data = np.load(filename)

    ts = saved_data['ts']

    l = len(ts)
    rl = len(ts[ts>10.0])

    p = l - rl
    ts = ts[p:]

    pose_positions = saved_data['pose_positions'][p:]
    pose_orientations = saved_data['pose_orientations'][p:]
    cf_positions = saved_data['cf_positions'][p:]
    ref_positions = saved_data['ref_positions'][p:]
    thrust_cmds = saved_data['thrust_cmds'][p:]
    ang_vel_cmds = saved_data['ang_vel_cmds'][p:]
    ppo_thrust = saved_data['ppo_acc'][p:]
    ppo_ang = saved_data['ppo_ang'][p:]

    print(pose_orientations.shape, pose_orientations.shape, cf_positions.shape, ts.shape, thrust_cmds.shape)

    plt.figure(0)
    ax1 = plt.subplot(3, 1, 1)
    plt.plot(ts, pose_positions[:, 0], label='/cf/pose position')
    plt.plot(ts, cf_positions[:, 0], label='cf.position()')
    plt.plot(ts, ref_positions[:, 0])
    plt.subplot(3, 1, 2, sharex=ax1)
    plt.plot(ts, pose_positions[:, 1], label='/cf/pose position')
    plt.plot(ts, cf_positions[:, 1], label='cf.position()')
    plt.plot(ts, ref_positions[:, 1])
    plt.subplot(3, 1, 3, sharex=ax1)
    plt.plot(ts, pose_positions[:, 2], label='/cf/pose position')
    plt.plot(ts, cf_positions[:, 2], label='cf.position()')
    plt.plot(ts, ref_positions[:, 2], label='ref position')
    plt.legend()
    plt.suptitle('positions (python)')


    plt.figure(1)
    ax2 = plt.subplot(3, 1, 1)
    plt.plot(ts, ang_vel_cmds[:, 0])
    plt.plot(ts,ppo_ang[:,0],color='red')
    plt.plot(ts,smoothing(ppo_ang[:,0]*0.35), label='smooth')

    # plt.plot(ts, pose_orientations[:, 2], color='red')
    plt.subplot(3, 1, 2, sharex=ax2)
    plt.plot(ts, ang_vel_cmds[:, 1])
    plt.plot(ts,ppo_ang[:,1]*1.0,color='red')
    plt.plot(ts,smoothing(ppo_ang[:,1]*0.7, length=5) +np.ones_like(ppo_ang[:,1])*3., label='smooth')

    # plt.plot(ts, pose_orientations[:, 1], color='red')
    plt.subplot(3, 1, 3, sharex=ax2)
    plt.plot(ts, ang_vel_cmds[:, 2], label='Ang Vel Cmd (deg/s)')
    plt.plot(ts,ppo_ang[:,2],color='red', label='ppo')
    plt.plot(ts,smoothing(ppo_ang[:,2])*0.6 + np.ones_like(ppo_ang[:,2])*6, label='smooth')

    # plt.plot(ts, pose_orientations[:, 0], color='red', label='Euler Angle (deg)')
    plt.suptitle('cppo & ang vel cmds')
    plt.legend()

    # plt.figure(2)
    # ax3 = plt.subplot(3, 1, 1)
    # plt.plot(ts, cf_positions[:, 0])
    # plt.subplot(3, 1, 2, sharex=ax3)
    # plt.plot(ts, cf_positions[:, 1])
    # plt.subplot(3, 1, 3, sharex=ax3)
    # plt.plot(ts, cf_positions[:, 2])
    # plt.suptitle('cf.position() (python)')

    plt.figure(3)
    plt.plot(ts, thrust_cmds, label = 'pid')
    plt.plot(ts, ppo_thrust, label = 'ppo')
    plt.plot(ts, smoothing(ppo_thrust, length=6), label = 'smooth')

    plt.title('Cmd z acc (python)')
    plt.legend()

    plt.show()

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("filename")

    args = parser.parse_args()
    filename = args.filename

    plot_npz(filename)
    
