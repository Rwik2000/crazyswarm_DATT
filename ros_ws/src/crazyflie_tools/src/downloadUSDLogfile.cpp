#include <iostream>

#include <boost/program_options.hpp>
#include <crazyflie_cpp/Crazyflie.h>

int main(int argc, char **argv)
{

  std::string uri;
  std::string defaultUri("radio://0/80/2M/E7E7E7E7E7");
  bool verbose = false;

  namespace po = boost::program_options;

  po::options_description desc("Allowed options");
  desc.add_options()
    ("help", "produce help message")
    ("uri", po::value<std::string>(&uri)->default_value(defaultUri), "unique ressource identifier")
    ("verbose,v", "verbose output")
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
    verbose = vm.count("verbose");
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
    cf.requestParamToc();

    const Crazyflie::ParamTocEntry* bcUSD = cf.getParamTocEntry("deck", "bcUSD");
    const Crazyflie::ParamTocEntry* logging = cf.getParamTocEntry("usd", "logging");

    if (bcUSD && logging) {
      if (cf.getParam<uint8_t>(bcUSD->id) != 1) {
        std::cerr << "USD deck is not initialized!" << std::endl;
        return 1;
      }
      if (cf.getParam<uint8_t>(logging->id) != 0) {
        std::cout << "Logging still enabled. Disabling logging." << std::endl;
        cf.setParam<uint8_t>(logging->id, 0);
        // return 1;
      }
    } else {
      std::cerr << "Could not find USD deck logging variables! Are you using the latest firmware?" << std::endl;
      return 1;
    }

    cf.requestMemoryToc();

    if (verbose) {
      auto iter = cf.memoriesBegin();
      const auto end = cf.memoriesEnd();
      for (;iter != end; ++iter) {
        if (iter->type == Crazyflie::MemoryTypeUSD) {
          std::cout << "File is " << iter->size << " bytes." << std::endl;
          break;
        }
      }
    }

    std::vector<uint8_t> data;

    auto start = std::chrono::high_resolution_clock::now();
    cf.readUSDLogFile(data);
    auto end = std::chrono::high_resolution_clock::now();
    
    if (verbose) {
      std::chrono::duration<double> duration = end-start;
      double t = duration.count();

      std::cout << "read " << data.size() << " in " << t << " s. (" << data.size() / t << " B/s)." << std::endl;
    }

    std::cout << "read " << data.size() << std::endl;

    std::ofstream out("output.log", std::ios::binary);
    out.write(reinterpret_cast<const char*>(data.data()), data.size());

    return 0;
  }
  catch(std::exception& e)
  {
    std::cerr << e.what() << std::endl;
    return 1;
  }
}
