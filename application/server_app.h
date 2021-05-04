#ifndef CA_LAYERS_SERVER_APP_H
#define CA_LAYERS_SERVER_APP_H

#include "ipc/ipc.h"
#include <memory>

@class CALayerHost;

class ServerApp {

public:
  explicit ServerApp() = default;
  ~ServerApp() = default;
  void run(int windows_count);

private:
  void initWindows(int windows_count);
  CALayerHost* getLayerHost();
};

#endif // CA_LAYERS_SERVER_APP_H
