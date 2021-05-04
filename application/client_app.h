#ifndef CA_LAYERS_CLIENT_APP_H
#define CA_LAYERS_CLIENT_APP_H

#include "ipc/ipc.h"
#include <memory>

@class CALayer;

class ClientApp {
public:
  ClientApp() = default;
  ~ClientApp() = default;

  void run(int windows_count);
  void initLayers(int windows_count);
  void exportLayer(CALayer* gl_layer);
};

#endif // CA_LAYERS_CLIENT_APP_H
