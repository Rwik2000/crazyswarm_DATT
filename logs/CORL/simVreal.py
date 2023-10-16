import numpy as np
import argparse
import matplotlib.pyplot as plt
from plt_utils import load_cf_data

def first_nonzero(arr, axis, invalid_val=-1):
    mask = arr!=0
    return np.where(mask.any(axis=axis), mask.argmax(axis=axis), invalid_val)

def rmse(ref, act):
    return np.sqrt(np.mean((ref - act) ** 2, axis=0))

def plot_npz(filenames, files_n_types, args):

    data_dict = load_cf_data(filenames, args)
    sim_key = list(data_dict.keys())[0]

    sim_rmse = rmse(data_dict[sim_key]['ref_positions'], data_dict[sim_key]['pose_positions'])
    print("sim RMSE : ", list(sim_rmse))

    real_rmse = []
    try:
        for key in list(data_dict.keys())[1:] :
            pos_rmse = rmse(data_dict[key]['ref_positions'], data_dict[key]['pose_positions']) 
            real_rmse.append(pos_rmse)

        real_rmse = np.mean(real_rmse, axis=0)
        print("real RMSE : ", list(real_rmse))
    except:
        pass


    # plt.plot(data_dict[filenames[0]]['ref_positions'][:, 0], data_dict[filenames[0]]['ref_positions'][:, 1])
    # plt.show()

    if args.showgraph:
        plt.figure(5)

        plt.plot(data_dict[filenames[0]]['ref_positions'][:, 1], data_dict[filenames[0]]['ref_positions'][:, 0])
        for key in data_dict.keys():
            plt.plot(data_dict[key]['pose_positions'][:, 1], data_dict[key]['pose_positions'][:, 0])
            # plt.plot(data_dict[key]['ts'], data_dict[key]['cf_positions'][:, 0], label='cf.position()')
        plt.grid()
        ax = plt.gca()
        ax.set_aspect('equal', 'box')

    if args.showgraph:
        plt.figure(0)
        ax1 = plt.subplot(3, 1, 1)
        plt.plot(data_dict[filenames[0]]['ts'], data_dict[filenames[0]]['ref_positions'][:, 0])
        for key in data_dict.keys():
            plt.plot(data_dict[key]['ts'], data_dict[key]['pose_positions'][:, 0])
            # plt.plot(data_dict[key]['ts'], data_dict[key]['cf_positions'][:, 0], label='cf.position()')
        plt.grid()
        
        plt.subplot(3, 1, 2, sharex=ax1)
        plt.plot(data_dict[filenames[0]]['ts'], data_dict[filenames[0]]['ref_positions'][:, 1])
        for key in data_dict.keys():
            plt.plot(data_dict[key]['ts'], data_dict[key]['pose_positions'][:, 1])
            # plt.plot(data_dict[key]['ts'], data_dict[key]['cf_positions'][:, 1], label='cf.position()')
        plt.grid()
        
        plt.subplot(3, 1, 3, sharex=ax1)
        plt.plot(data_dict[filenames[0]]['ts'], data_dict[filenames[0]]['ref_positions'][:, 2],label='ref')
        for key in data_dict.keys():
            plt.plot(data_dict[key]['ts'], data_dict[key]['pose_positions'][:, 2], label=files_n_types[key])
            # plt.plot(data_dict[key]['ts'], data_dict[key]['cf_positions'][:, 2], label=key+'_cf.position()')
        plt.grid()

        plt.legend()
        plt.suptitle(args.title + '   Position \n Sim RMSE {} \n Real RMSE {}'.format(np.round(sim_rmse, 3), np.round(real_rmse,3)))
        if args.showgraph==1:
            plt.savefig('temp', dpi=199)
            os.rename('temp.png',  'plots/' + args.simtag + '.png')
        
        plt.figure(1)
        ax1 = plt.subplot(3, 1, 1)
        for key in data_dict.keys():
            # plt.plot(data_dict[key]['ts'], data_dict[key]['pose_positions'][:, 0], label='/cf/pose position')
            plt.plot(data_dict[key]['ts'], data_dict[key]['pose_orientations'][:, 0], label=key+'_cf.position()')
            plt.plot(data_dict[key]['ts'], data_dict[key]['ref_orientation'][:, 0])
        plt.subplot(3, 1, 2, sharex=ax1)
        for key in data_dict.keys():
            # plt.plot(data_dict[key]['ts'], data_dict[key]['pose_positions'][:, 1], label='/cf/pose position')
            plt.plot(data_dict[key]['ts'], data_dict[key]['pose_orientations'][:, 1], label=key+'_cf.position()')
            plt.plot(data_dict[key]['ts'], data_dict[key]['ref_orientation'][:, 1])
        plt.subplot(3, 1, 3, sharex=ax1)
        for key in data_dict.keys():
            # plt.plot(data_dict[key]['ts'], data_dict[key]['pose_positions'][:, 2], label='/cf/pose position')
            plt.plot(data_dict[key]['ts'], data_dict[key]['pose_orientations'][:, 2], label=key+'_cf.position()')
            plt.plot(data_dict[key]['ts'], data_dict[key]['ref_orientation'][:, 2],label=key+'_ref position')
        plt.legend()
        plt.suptitle(args.title + '  Attitude')
    
    
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
        plt.suptitle(args.title + '  position error')


        plt.figure(3)
       
        ax1 = plt.subplot(3, 1, 1)
        plt.plot(data_dict[filenames[0]]['ts'], data_dict[filenames[0]]['ang_vel_cmds'][:, 0])
        for key in data_dict.keys():
            plt.plot(data_dict[key]['ts'], data_dict[key]['ang_vel_cmds'][:, 0])
        
        plt.subplot(3, 1, 2, sharex=ax1)

        plt.plot(data_dict[filenames[0]]['ts'], data_dict[filenames[0]]['ang_vel_cmds'][:, 1])
        for key in data_dict.keys():
            plt.plot(data_dict[key]['ts'], data_dict[key]['ang_vel_cmds'][:, 1])
       
        plt.subplot(3, 1, 3, sharex=ax1)
        plt.plot(data_dict[filenames[0]]['ts'], data_dict[filenames[0]]['ang_vel_cmds'][:, 2], label='ref')
        for key in data_dict.keys():
            plt.plot(data_dict[key]['ts'], data_dict[key]['ang_vel_cmds'][:, 2], label=files_n_types[key])
        plt.legend()        
        plt.suptitle(args.title + '  ang_vel_cmds')

        plt.figure(4)
        for key in data_dict.keys():
            plt.plot(data_dict[key]['ts'], data_dict[key]['thrust_cmds'], label=files_n_types[key])
        plt.legend()        
        plt.title('Cmd z acc (python)')



            # plt.plot(data_dict[key]['ts'], data_dict[key]['cf_positions'][:, 0], label='cf.position()')
        plt.grid()
        if args.showgraph == 2:
            plt.show()

if __name__ == "__main__":

    from argparse import ArgumentParser
    import os

    parser = ArgumentParser()
    parser.add_argument("--simtag", type = str, default=None)
    parser.add_argument("--exp-date", dest="exp_date", type=str, default="may_17")
    parser.add_argument("--plotall", type = bool, default = False)
    parser.add_argument("-sg", "--showgraph", type=int, default=0)
    parser.add_argument("--runtime", type=float, default=10)
    parser.add_argument("--title", type=str, default="")
    parser.add_argument("--hovertime",type=float,default=0)
    parser.add_argument("-tt", "--takeofftime",type=float,default=5.0)
    parser.add_argument("-bh", "--baseheight", type=float, default=1.0)

    args = parser.parse_args()

    exp_date = args.exp_date
    plotall = args.plotall
    simtag = args.simtag

    print("RUN : ", simtag)

    files = []
    files_n_types = {}
    
    # sim
    files.append(exp_date + "/sim/" + simtag + ".npz")
    files_n_types = {exp_date + "/sim/" + simtag + ".npz" : "sim"}

    # real
    for i in range(6):
        if os.path.exists(exp_date + "/real/" + simtag + "_{}.npz".format(i)):
            files.append(exp_date + "/real/" + simtag + "_{}.npz".format(i))
            files_n_types[exp_date + "/real/" + simtag + "_{}.npz".format(i)] = "real_{}".format(i)

        else:
            break

    plot_npz(files, files_n_types, args)
    print("\n")

    
