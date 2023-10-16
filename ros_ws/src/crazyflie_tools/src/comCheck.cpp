#include <iostream>
#include <chrono>

#include <boost/program_options.hpp>
#include <crazyflie_cpp/Crazyflie.h>
#include <crazyflie_cpp/crtp.h>

struct crtpMyPacket
{
  crtpMyPacket(
    uint64_t id,
    uint64_t time_since_epoch)
    : header(15, 0) // Link, echo
    , id(id)
    , time_since_epoch(time_since_epoch)
  {
  }
  const crtp header;
  const uint64_t id;
  uint64_t time_since_epoch;
} __attribute__((packed));

uint64_t getTimestamp()
{
  auto now = std::chrono::high_resolution_clock::now();
  auto now_us = std::chrono::time_point_cast<std::chrono::milliseconds>(now);

  auto value = now_us.time_since_epoch();
  uint64_t time_since_epoch = value.count();
  return time_since_epoch;
}

// stats
uint32_t numPacketsReceived = 0;
uint64_t sumRoundtripTime = 0;

uint32_t linkQualitySent = 0;
uint32_t linkQualityAcked = 0;

void onGenericPacket(const ITransport::Ack& ack)
{
  uint64_t time_since_epoch = getTimestamp();

  const crtpMyPacket* packet = reinterpret_cast<const crtpMyPacket*>(ack.data);
  uint64_t roundtripTime = time_since_epoch - packet->time_since_epoch;
  // std::cout << "packet!" << (int)ack.size << " " << packet->id << " " << roundtripTime << " ms" << std::endl;

  sumRoundtripTime += roundtripTime;
  ++numPacketsReceived;
}

void onEmptyAck(const crtpPlatformRSSIAck* cb)
{
  std::cout << "RSSI: " << (int)cb->rssi << std::endl;
}

void onLinkQuality(float quality)
{
  linkQualitySent += 100;
  linkQualityAcked += quality * 100;
  // std::cout << "Link quality: " << quality << std::endl;
}

int main(int argc, char **argv)
{

  std::string uri;
  std::string defaultUri("radio://0/80/2M/E7E7E7E7E7");
  uint32_t numPackets;

  namespace po = boost::program_options;

  po::options_description desc("Allowed options");
  desc.add_options()
    ("help", "produce help message")
    ("uri", po::value<std::string>(&uri)->default_value(defaultUri), "unique ressource identifier")
    ("numPackets", po::value<uint32_t>(&numPackets)->default_value(1000), "unique ressource identifier")
  ;

  try
  {
    po::variables_map vm;
    po::store(po::parse_command_line(argc, argv, desc), vm);
    po::notify(vm);

    if (vm.count("help")) {
      std::cout << desc << "\n";
      return 0;
    }
  }
  catch(po::error& e)
  {
    std::cerr << e.what() << std::endl << std::endl;
    std::cerr << desc << std::endl;
    return 1;
  }

  try
  {
    Crazyflie cf(uri);

    cf.setEmptyAckCallback(onEmptyAck);
    cf.setLinkQualityCallback(onLinkQuality);

    // send pings to clear queue
    for (size_t i = 0; i < 1000; ++i) {
      cf.sendPing();
    }

    cf.setGenericPacketCallback(onGenericPacket);

    uint64_t start = getTimestamp();
    for (uint64_t id = 0; id < numPackets; ++id) {
      uint64_t time_since_epoch = getTimestamp();

      crtpMyPacket p(id, time_since_epoch);
      // std::cout << "send " << id << " " << time_since_epoch << std::endl;

      crtpPacket_t packet;
      packet.size = sizeof(crtpMyPacket)-1;
      packet.header = *reinterpret_cast<const uint8_t*>(&p.header);
      memcpy(packet.data, &p.id, sizeof(crtpMyPacket)-1);

      cf.queueOutgoingPacket(packet);
      cf.transmitPackets();
    }
    uint64_t timeToSent = getTimestamp() - start;

    // send pings to clear queue
    for (size_t i = 0; i < 1000; ++i) {
      cf.sendPing();
    }

    std::cout << "numPacketsReceived: " << numPacketsReceived / (double)numPackets * 100.0f << " %" << std::endl;
    std::cout << "Avg. roundtrip time: " << sumRoundtripTime / (double) numPacketsReceived << " ms" << std::endl;
    std::cout << numPackets / (timeToSent / 1000.0f) << " packets/s sent" << std::endl;
    std::cout << "link quality: " << linkQualityAcked / (float)linkQualitySent << std::endl;


    return 0;
  }
  catch(std::exception& e)
  {
    std::cerr << e.what() << std::endl;
    return 1;
  }
}
