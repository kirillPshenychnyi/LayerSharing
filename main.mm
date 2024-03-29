#include "application/host_app.h"
#include "application/renderer_app.h"

int main(int argc, char* argv[]) {
  constexpr int kNumberWindows = 2;
  if (ipc::Ipc::instance().fork_process()) {
    HostApp server_app;
    server_app.run(kNumberWindows);
  } else {
    RendererApp client_app;
    client_app.run();
  }
  return 0;
}
