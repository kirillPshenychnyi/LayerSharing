#ifndef CA_LAYERS_RENDERER_APP_H
#define CA_LAYERS_RENDERER_APP_H

#include "ipc/ipc.h"
#include <memory>

@class CALayer;

class RendererApp {
public:
  RendererApp() = default;
  ~RendererApp() = default;

  void run(int windows_count);
  void initLayers(int windows_count);
  void exportLayer(CALayer* gl_layer);
};

#endif // CA_LAYERS_RENDERER_APP_H
