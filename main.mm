#include "application/host_app.h"
#include "application/renderer_app.h"
#include "ipc/ipc.h"

int main(int argc, char* argv[]) {
  constexpr int kNumberWindows = 2;
  if (ipc::Ipc::instance().fork_process()) {
    HostApp server_app;
    server_app.run(kNumberWindows);
  } else {
    RendererApp client_app;
    client_app.run(kNumberWindows);
  }
  return 0;
}
