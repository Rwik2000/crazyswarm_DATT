#include <iostream>
#include <fstream>
#include <inttypes.h>

#include <boost/program_options.hpp>
#include <crazyflie_cpp/Crazyflie.h>

std::istream& operator>>(std::istream& in, Crazyflie::BootloaderTarget& target)
{
  std::string token;
  in >> token;
  if (token == "stm32")
    target = Crazyflie::TargetSTM32;
  else if (token == "nrf51")
    target = Crazyflie::TargetNRF51;
  else throw boost::program_options::validation_error(boost::program_options::validation_error::invalid_option_value);
  return in;
}

enum Mode
{
  FlashAndVerify,
  FlashOnly,
  VerifyOnly,
};

std::istream& operator>>(std::istream& in, Mode& mode)
{
  std::string token;
  in >> token;
  if (token == "flashAndVerify")
    mode = FlashAndVerify;
  else if (token == "flashOnly")
    mode = FlashOnly;
  else if (token == "verifyOnly")
    mode = VerifyOnly;
  else throw boost::program_options::validation_error(boost::program_options::validation_error::invalid_option_value);
  return in;
}

class MyLogger : public Logger
{
public:
  MyLogger(bool verbose)
    : m_verbose(verbose)
  {
  }

  virtual void info(const std::string& msg)
  {
    if (m_verbose) {
      std::cout << msg << std::endl;
    }
  }
  // virtual void warning(const std::string& /*msg*/) {}
  // virtual void error(const std::string& /*msg*/) {}
private:
  bool m_verbose;
};

int main(int argc, char **argv)
{

  std::string fileName;
  std::string uri;
  std::string defaultUri("radio://0/0/2M");
  Crazyflie::BootloaderTarget target;
  Mode mode = FlashAndVerify;
  bool verbose = false;

  namespace po = boost::program_options;

  po::options_description desc("Allowed options");
  desc.add_options()
    ("help", "produce help message")
    ("target", po::value<Crazyflie::BootloaderTarget>(&target)->required(), "target {stm32,nrf51}")
    ("filename", po::value<std::string>(&fileName)->required(), "file to flash")
    ("uri", po::value<std::string>(&uri)->default_value(defaultUri), "unique ressource identifier")
    ("mode", po::value<Mode>(&mode)->default_value(mode), "mode {default=flashAndVerify, flashOnly, verifyOnly}")
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
    MyLogger logger(verbose);

    bool success = true;
    Crazyflie cf(uri, logger);
    if (uri != defaultUri) {
      logger.info("Reboot to Bootloader...");
      uint64_t address = cf.rebootToBootloader();
      logger.info("...Done");

      char addr[17];
      std::sprintf(addr, "%" SCNx64, address);
      defaultUri += "/" + std::string(addr);
    }

    std::ifstream stream(fileName.c_str(), std::ios::binary);
    if (!stream.good()) {
      std::cerr << "Couldn't open " << fileName << "!" << std::endl;
      return 1;
    }
    std::vector<uint8_t> targetData((
      std::istreambuf_iterator<char>(stream)),
      (std::istreambuf_iterator<char>()));

    // Crazyflie cf(defaultUri, logger);

    if (mode == FlashAndVerify || mode == FlashOnly) {
      logger.info("Flashing...");
      cf.writeFlash(target, targetData);
    }
    if (mode == FlashAndVerify || mode == VerifyOnly) {
      logger.info("Reading...");
      std::vector<uint8_t> currentData;
      cf.readFlash(target, targetData.size(), currentData);
      std::ofstream dbg("data.bin", std::ios::binary);
      dbg.write((char*)currentData.data(), currentData.size());
      if (memcmp(targetData.data(), currentData.data(), targetData.size()) == 0) {
        logger.info("Verification successful!");
      } else {
        std::cerr << "Verification NOT successful!" << std::endl;
        success = false;
      }
    }

    logger.info("Reboot to firmware");
    cf.rebootFromBootloader();

    if (success) {
      return 0;
    }
    return 1;
  }
  catch(std::exception& e)
  {
    std::cerr << e.what() << std::endl;
    return 1;
  }
}
