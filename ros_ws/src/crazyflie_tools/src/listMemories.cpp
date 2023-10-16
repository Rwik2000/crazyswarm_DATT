#include <iostream>

#include <boost/program_options.hpp>
#include <crazyflie_cpp/Crazyflie.h>

int main(int argc, char **argv)
{

  std::string uri;
  std::string defaultUri("radio://0/80/2M/E7E7E7E7E7");

  namespace po = boost::program_options;

  po::options_description desc("Allowed options");
  desc.add_options()
    ("help", "produce help message")
    ("uri", po::value<std::string>(&uri)->default_value(defaultUri), "unique ressource identifier")
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
    cf.requestMemoryToc();

     std::for_each(cf.memoriesBegin(), cf.memoriesEnd(),
      [](const Crazyflie::MemoryTocEntry& entry)
      {
        std::cout << (int)entry.id << ": " << std::endl;
        std::cout << "  type: ";
        switch (entry.type) {
        case Crazyflie::MemoryTypeEEPROM:
          std::cout << "EEPROM";
          break;
        case Crazyflie::MemoryTypeOneWire:
          std::cout << "1-Wire";
          break;
        case Crazyflie::MemoryTypeLED12:
          std::cout << "LED12";
          break;
        case Crazyflie::MemoryTypeLOCO:
          std::cout << "LOCO";
          break;
        default:
          std::cout << "Unknown type!";
          break;
        }
        std::cout << std::endl;
        std::cout << "  size: " << entry.size << std::endl;
        std::cout << "  addr: " << entry.addr << std::endl;
      }
    );

    return 0;
  }
  catch(std::exception& e)
  {
    std::cerr << e.what() << std::endl;
    return 1;
  }
}
