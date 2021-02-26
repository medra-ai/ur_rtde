#include <ur_rtde/rtde_io_interface.h>
#include <ur_rtde/rtde_receive_interface.h>

#include <iostream>
#include <thread>

using namespace ur_rtde;
using namespace std;

namespace
{
const char* boolToString(bool b)
{
  return b ? "true" : "false";
}
}  // namespace

int main(int argc, char* argv[])
{
  std::string hostname {"127.0.0.1"};
  if (argc == 2) {
    hostname = argv[1];
  }

  RTDEIOInterface rtde_io(hostname);
  RTDEReceiveInterface rtde_receive(hostname);

  /** How-to set and get standard and tool digital outputs. Notice that we need the
   * RTDEIOInterface for setting an output and RTDEReceiveInterface for getting the state
   * of an output.
   */

  cout << "Standard digital out (7) is " << boolToString(rtde_receive.getDigitalOutState(7)) << endl;
  cout << "Standard digital out (16) is " << boolToString(rtde_receive.getDigitalOutState(16)) << endl;

  rtde_io.setStandardDigitalOut(7, true);
  rtde_io.setToolDigitalOut(0, true);
  this_thread::sleep_for(chrono::milliseconds(10));

  cout << "Standard digital out (7) is " << boolToString(rtde_receive.getDigitalOutState(7)) << endl;
  cout << "Standard digital out (16) is " << boolToString(rtde_receive.getDigitalOutState(16)) << endl;

  // How to set a analog output with a specified current ratio
  rtde_io.setAnalogOutputCurrent(1, 0.25);

  return EXIT_SUCCESS;
}
