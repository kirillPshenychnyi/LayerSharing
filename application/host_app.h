#ifndef CA_LAYERS_SERVER_APP_H
#define CA_LAYERS_SERVER_APP_H

#include "ipc/ipc.h"
#import "rendering/remote_layer_api.h"
#include <memory>

@class CALayerHost;

class HostApp {

public:
  explicit HostApp() = default;
  ~HostApp() = default;
  void run(int windows_count);

private:
  void initWindows(int windows_count);
  CALayerHost* getLayerHost();

  CAContextID context_id_ = 0;
};

#endif // CA_LAYERS_SERVER_APP_H
