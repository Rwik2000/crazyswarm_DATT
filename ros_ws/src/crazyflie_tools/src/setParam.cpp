#include <iostream>

#include <boost/program_options.hpp>
#include <crazyflie_cpp/Crazyflie.h>

int main(int argc, char **argv)
{

  std::string uri;
  std::string defaultUri("radio://0/80/2M/E7E7E7E7E7");
  std::string parameter;

  namespace po = boost::program_options;

  po::options_description desc("Allowed options");
  desc.add_options()
    ("help", "produce help message")
    ("parameter", po::value<std::string>(&parameter)->required(), "parameter name")
    ("valUint8", po::value<int>(), "value (uint8)")
    ("valInt8", po::value<int>(), "value (int8)")
    ("valUint16", po::value<uint16_t>(), "value (uint16)")
    ("valInt16", po::value<int16_t>(), "value (int16)")
    ("valUint32", po::value<uint32_t>(), "value (uint32)")
    ("valInt32", po::value<int32_t>(), "value (int32)")
    ("valFloat", po::value<float>(), "value (float)")
    ("uri", po::value<std::string>(&uri)->default_value(defaultUri), "unique ressource identifier")
  ;

  po::variables_map vm;
  try
  {
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

    auto pos = parameter.find(".");
    const char* group = parameter.substr(0, pos).c_str();
    const char* name = parameter.substr(pos+1).c_str();

    if (vm.count("valUint8")) {
      cf.setParamByName<uint8_t>(group, name, (uint8_t)vm["valUint8"].as<int>());
    } else if (vm.count("valInt8")) {
      cf.setParamByName<int8_t>(group, name, (int8_t)vm["valInt8"].as<int>());
    } else if (vm.count("valUint16")) {
      cf.setParamByName<uint16_t>(group, name, vm["valUint16"].as<uint16_t>());
    } else if (vm.count("valInt16")) {
      cf.setParamByName<int16_t>(group, name, vm["valInt16"].as<int16_t>());
    } else if (vm.count("valUint32")) {
      cf.setParamByName<uint32_t>(group, name, vm["valUint32"].as<uint32_t>());
    } else if (vm.count("valInt32")) {
      cf.setParamByName<int32_t>(group, name, vm["valInt32"].as<int32_t>());
    } else if (vm.count("valFloat")) {
      cf.setParamByName<float>(group, name, vm["valFloat"].as<float>());
    } else {
      std::cerr << "Required to use one of the --val* arguments!" << std::endl << std::endl;
      std::cerr << desc << std::endl;
      return 1;
    }

    return 0;
  }
  catch(std::exception& e)
  {
    std::cerr << e.what() << std::endl;
    return 1;
  }
}
