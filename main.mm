#include "application/client_app.h"
#include "application/server_app.h"
#include "ipc/ipc.h"

int main(int argc, char* argv[]) {
  constexpr int kNumberWindows = 2;
  if (ipc::Ipc::instance().fork_process()) {
    ServerApp server_app;
    server_app.run(kNumberWindows);
  } else {
    ClientApp client_app;
    client_app.run(kNumberWindows);
  }
  return 0;
}
