import numpy as np
import argparse
import matplotlib.pyplot as plt

def first_nonzero(arr, axis, invalid_val=-1):
    mask = arr!=0
    return np.where(mask.any(axis=axis), mask.argmax(axis=axis), invalid_val)

def plot_npz(filename):

    data_dict={}
    # minimum_len={}
    for i in filename:
        data = {}
        saved_data = np.load(i) 
    # saved_data = np.load(filename)

        minimum_len = np.inf
        for key in saved_data.keys():
            k = len(saved_data[key])
            if k<minimum_len:
                minimum_len = k
        st= first_nonzero(saved_data['ref_positions'],0)[0]
        # st = 0

        # print(saved_data['pose_positions'][st])
        data['pose_positions'] = saved_data['pose_positions'][st:k] - saved_data['pose_positions'][st]
        data['pose_orientations'] = saved_data['pose_orientations'][st:k]
        data['pose_positions'] = saved_data['pose_positions'][st:k] - saved_data['pose_positions'][st]
        data['ts'] = saved_data['ts'][st:k]
        data['ref_positions'] = saved_data['ref_positions'][st:k] - saved_data['ref_positions'][st]
        data['ref_orientation'] = saved_data['ref_orientation'][st:k]
        data['thrust_cmds'] = saved_data['thrust_cmds'][st:k]
        data['ang_vel_cmds'] = saved_data['ang_vel_cmds'][st:k]
        # data['mocap_orientation'] = saved_data['motrack_orientation'][st:k]

        data_dict[i] = data
    # print(pose_orientations.shape)
    # print(np.diff(pose_orientations).shape)
    # ang_vels = np.diff(pose_orientations,axis=-1)/ts
    # ang_vels = np.append(ang_vels,ang_vels[-1],axis=0)
    # offs = mocap_orientation[0] - pose_orientations[0]

    

    # print(pose_orientations.shape, pose_orientations.shape, pose_positions.shape, ts.shape, thrust_cmds.shape)
    
    plt.figure(0)
    ax1 = plt.subplot(3, 1, 1)
    for key in data_dict.keys():
        plt.plot(data_dict[key]['ts'], data_dict[key]['pose_positions'][:, 0], label='/cf/pose position')
        # plt.plot(data_dict[key]['ts'], data_dict[key]['pose_positions'][:, 0], label='cf.position()')
        plt.plot(data_dict[key]['ts'], data_dict[key]['ref_positions'][:, 0])
    plt.subplot(3, 1, 2, sharex=ax1)
    for key in data_dict.keys():
        plt.plot(data_dict[key]['ts'], data_dict[key]['pose_positions'][:, 1], label='/cf/pose position')
        # plt.plot(data_dict[key]['ts'], data_dict[key]['pose_positions'][:, 1], label='cf.position()')
        plt.plot(data_dict[key]['ts'], data_dict[key]['ref_positions'][:, 1])
    plt.subplot(3, 1, 3, sharex=ax1)
    for key in data_dict.keys():
        plt.plot(data_dict[key]['ts'], data_dict[key]['pose_positions'][:, 2], label='/cf/pose position')
        # plt.plot(data_dict[key]['ts'], data_dict[key]['pose_positions'][:, 2], label=key+'_cf.position()')
        plt.plot(data_dict[key]['ts'], data_dict[key]['ref_positions'][:, 2],label=key+'_ref position')
    plt.legend()
    plt.suptitle('PPO curriculum')
    
    pos_rmse = np.sqrt(np.mean(data_dict[key]['pose_positions'] - data_dict[key]['ref_positions'], axis=0) ** 2)
    print("position RMSE : ", pos_rmse)
    print("total position RMSE", np.linalg.norm(pos_rmse))
    error = data_dict[key]['ref_positions'] - data_dict[key]['pose_positions']

    plt.figure(1)
    ax1 = plt.subplot(3, 1, 1)
    for key in data_dict.keys():
        # plt.plot(data_dict[key]['ts'], data_dict[key]['pose_positions'][:, 0], label='/cf/pose position')
        plt.plot(data_dict[key]['ts'], data_dict[key]['pose_orientations'][:, 0], label='cf.position()')
        plt.plot(data_dict[key]['ts'], data_dict[key]['ref_orientation'][:, 0])
    plt.subplot(3, 1, 2, sharex=ax1)
    for key in data_dict.keys():
        # plt.plot(data_dict[key]['ts'], data_dict[key]['pose_positions'][:, 1], label='/cf/pose position')
        plt.plot(data_dict[key]['ts'], data_dict[key]['pose_orientations'][:, 1], label='cf.position()')
        plt.plot(data_dict[key]['ts'], data_dict[key]['ref_orientation'][:, 1])
    plt.subplot(3, 1, 3, sharex=ax1)
    for key in data_dict.keys():
        # plt.plot(data_dict[key]['ts'], data_dict[key]['pose_positions'][:, 2], label='/cf/pose position')
        plt.plot(data_dict[key]['ts'], data_dict[key]['pose_orientations'][:, 2], label=key+'_cf.position()')
        plt.plot(data_dict[key]['ts'], data_dict[key]['ref_orientation'][:, 2],label=key+'_ref position')
    plt.legend()
    plt.suptitle('PPO curriculum attitude')


    plt.figure(2)
    ax1 = plt.subplot(3, 1, 1)
    for key in data_dict.keys():
        zero_error = np.zeros_like(data_dict[key]['ts'])
        # plt.plot(data_dict[key]['ts'], data_dict[key]['pose_positions'][:, 0], label='/cf/pose position')
        plt.plot(data_dict[key]['ts'], data_dict[key]['ref_positions'][:, 0] - data_dict[key]['pose_positions'][:, 0], label='cf.position()')
        plt.plot(data_dict[key]['ts'], zero_error)
    plt.subplot(3, 1, 2, sharex=ax1)
    for key in data_dict.keys():
        zero_error = np.zeros_like(data_dict[key]['ts'])
        # plt.plot(data_dict[key]['ts'], data_dict[key]['pose_positions'][:, 1], label='/cf/pose position')
        plt.plot(data_dict[key]['ts'], data_dict[key]['ref_positions'][:, 1] - data_dict[key]['pose_positions'][:, 1], label='cf.position()')
        plt.plot(data_dict[key]['ts'], zero_error)
    plt.subplot(3, 1, 3, sharex=ax1)
    for key in data_dict.keys():
        zero_error = np.zeros_like(data_dict[key]['ts'])
        # plt.plot(data_dict[key]['ts'], data_dict[key]['pose_positions'][:, 2], label='/cf/pose position')
        plt.plot(data_dict[key]['ts'], data_dict[key]['ref_positions'][:, 2] - data_dict[key]['pose_positions'][:, 2], label=key+'_cf.position()')
        plt.plot(data_dict[key]['ts'], zero_error, label=key+'zero error')
    plt.legend()
    plt.suptitle('position error')

    plt.figure(3)
    for key in data_dict.keys():
        plt.plot(data_dict[key]['ts'], data_dict[key]['thrust_cmds'])
    plt.title('Cmd z acc (python)')

    plt.show()

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("filename", nargs="+")

    args = parser.parse_args()
    filenames = args.filename
    # print(filename)
    # exit()

    plot_npz(filenames)
    
