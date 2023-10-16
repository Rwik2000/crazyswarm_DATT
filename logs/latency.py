import cflib
import time
import struct
import numpy as np

import cflib.crtp
from cflib.crtp.crtpstack import CRTPPacket
from cflib.crtp.crtpstack import CRTPPort

uri = 'radio://0/80/2M/E7E7E7E705'
cflib.crtp.init_drivers()
def latency(uri, packet_size = 4, count = 500):
    link = cflib.crtp.get_link_driver(uri)
    # # wait until no more packets in queue
    # while True:
    #     pk = link.receive_packet(0.5)
    #     print(pk)
    #     if not pk or pk.header == 0xFF:
    #         break

    pk = CRTPPacket()
    pk.set_header(CRTPPort.LINKCTRL, 0)  # Echo channel

    latencies = []
    for i in range(count):
        pk.data = build_data(i, packet_size)

        start_time = time.time()
        link.send_packet(pk)
        while True:
            pk_ack = link.receive_packet(-1)
            if pk_ack.port == CRTPPort.LINKCTRL and pk_ack.channel == 0:
                break
        end_time = time.time()

        # make sure we actually received the expected value
        i_recv, = struct.unpack('<I', pk_ack.data[0:4])
        # self.assertEqual(i, i_recv)
        latencies.append((end_time - start_time) * 1000)
    link.close()
    result = np.mean(latencies)
    print("Latency for {} (packet size {} B): {:.2f} ms".format(uri, packet_size, result))
    return result


def bandwidth(uri, packet_size = 4, count = 500):
    print(uri)
    link = cflib.crtp.get_link_driver(uri)
    # # wait until no more packets in queue
    # while True:
    #     pk = link.receive_packet(0.5)
    #     if not pk:
    #         break

    # enqueue packets
    start_time = time.time()
    for i in range(count):
        pk = CRTPPacket()
        pk.set_header(CRTPPort.LINKCTRL, 0)  # Echo channel
        pk.data = build_data(i, packet_size)
        link.send_packet(pk)

    # get the result
    for i in range(count):
        while True:
            pk_ack = link.receive_packet(-1)
            if pk_ack.port == CRTPPort.LINKCTRL and pk_ack.channel == 0:
                break
        # make sure we actually received the expected value
        i_recv, = struct.unpack('<I', pk_ack.data[0:4])
        # self.assertEqual(i, i_recv)
    end_time = time.time()
    link.close()
    result = count / (end_time - start_time)
    kbps = (count * packet_size) / 1024 / (end_time - start_time)
    print("Bandwith for {} (packet size {} B): {:.2f} packets/s ({:.2f} kB/s)".format(uri, packet_size, result, kbps))
    return result

def build_data(i, packet_size):
        assert(packet_size % 4 == 0)
        repeats = packet_size // 4
        return struct.pack('<' + 'I'*repeats, *[i]*repeats)

if __name__ == "__main__":
    # while True:
    #     link = cflib.crtp.get_link_driver(uri)
    #     print(link)

    latency(uri, 4)
    # bandwidth(uri)
