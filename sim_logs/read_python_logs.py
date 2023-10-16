import numpy as np
import argparse
import matplotlib.pyplot as plt


def plot_npz(filename):
    saved_data = np.load(filename)

    pose_positions = saved_data['pose_positions']
    pose_orientations = saved_data['pose_orientations']
    # cf_positions = saved_data['cf_positions']
    ts = saved_data['ts']
    ref_positions = saved_data['ref_positions']
    thrust_cmds = saved_data['thrust_cmds']
    ang_vel_cmds = saved_data['ang_vel_cmds']

    # print(pose_orientations.shape, pose_orientations.shape, cf_positions.shape, ts.shape, thrust_cmds.shape)

    plt.figure()
    ax1 = plt.subplot(3, 1, 1)
    plt.plot(ts, pose_positions[:, 0], label='/cf/pose position')
    # plt.plot(ts, cf_positions[:, 0], label='cf.position()')
    plt.plot(ts, ref_positions[:, 0])
    plt.subplot(3, 1, 2, sharex=ax1)
    plt.plot(ts, pose_positions[:, 1], label='/cf/pose position')
    # plt.plot(ts, cf_positions[:, 1], label='cf.position()')
    plt.plot(ts, ref_positions[:, 1])
    plt.subplot(3, 1, 3, sharex=ax1)
    plt.plot(ts, pose_positions[:, 2], label='/cf/pose position')
    # plt.plot(ts, cf_positions[:, 2], label='cf.position()')
    plt.plot(ts, ref_positions[:, 2], label='ref position')
    plt.legend()
    plt.suptitle('positions (python)')
    plt.savefig("plots/position.png")

    pos_rmse = np.sqrt(np.mean(pose_positions - ref_positions, axis=0) ** 2)
    print("position RMSE : ", pos_rmse)
    print("total position RMSE", np.linalg.norm(pos_rmse))
    error = ref_positions - pose_positions

    plt.figure()
    ax = plt.subplot(3, 1, 1)
    plt.plot(ts, error[:, 0])
    plt.subplot(3, 1, 2, sharex=ax)
    plt.plot(ts, error[:, 1])
    plt.subplot(3, 1, 3, sharex=ax)
    plt.plot(ts, error[:, 2])
    plt.savefig('plots/error.png')

    plt.figure()
    ax2 = plt.subplot(3, 1, 1)
    plt.plot(ts, ang_vel_cmds[:, 0])
    plt.plot(ts, pose_orientations[:, 2], color='red')
    plt.subplot(3, 1, 2, sharex=ax2)
    plt.plot(ts, ang_vel_cmds[:, 1])
    plt.plot(ts, pose_orientations[:, 1], color='red')
    plt.subplot(3, 1, 3, sharex=ax2)
    plt.plot(ts, ang_vel_cmds[:, 2], label='Ang Vel Cmd (deg/s)')
    plt.plot(ts, pose_orientations[:, 0], color='red', label='Euler Angle (deg)')
    plt.suptitle('cf/pose orientation (python) & ang vel cmds')
    plt.legend()
    plt.savefig("plots/angvel.png")


    # plt.figure(2)
    # ax3 = plt.subplot(3, 1, 1)
    # plt.plot(ts, cf_positions[:, 0])
    # plt.subplot(3, 1, 2, sharex=ax3)
    # plt.plot(ts, cf_positions[:, 1])
    # plt.subplot(3, 1, 3, sharex=ax3)
    # plt.plot(ts, cf_positions[:, 2])
    # plt.suptitle('cf.position() (python)')

    plt.figure()
    plt.plot(ts, thrust_cmds)
    plt.title('Cmd z acc (python)')
    plt.savefig("plots/thrust.png")
    plt.show()

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("filename")

    args = parser.parse_args()
    filename = args.filename

    plot_npz(filename)
    
