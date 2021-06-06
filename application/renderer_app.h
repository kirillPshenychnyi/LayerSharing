#ifndef CA_LAYERS_RENDERER_APP_H
#define CA_LAYERS_RENDERER_APP_H

#include "ipc/ipc.h"
#include <memory>

@class CALayer;

class RendererApp {
public:
  RendererApp() = default;
  ~RendererApp() = default;

  void run();
private:
  void initLayer();
  void exportLayer(CALayer* gl_layer);
};

#endif // CA_LAYERS_RENDERER_APP_H
