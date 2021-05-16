#define GL_SILENCE_DEPRECATION

#import "renderer_app.h"
#import "app_delegate.h"
#import "rendering/client_gl_layer.h"
#import "rendering/remote_layer_api.h"

@interface ClientApplication : NSApplication

@end

@implementation ClientApplication : NSApplication
@end

void RendererApp::run(int windows_count) {
  [ClientApplication sharedApplication];
  [NSApp setDelegate: [AppDelegate new]];
  initLayers(windows_count);
  [NSApp run];
}

void RendererApp::initLayers(int windows_count) {
  for (int i = 0; i < windows_count; ++i) {
    printf("Client: Creating a regular CALayer to export\n");
    ClientGlLayer *gl_layer = [[ClientGlLayer alloc] initWithIndex:i];
    [gl_layer setBackgroundColor:CGColorCreateGenericRGB(0, 1, 0, 1)];
    [gl_layer setBounds:CGRectMake(0, 0, 480, 480)];
    [gl_layer setAsynchronous:YES];

    exportLayer(gl_layer);
  }
}

void RendererApp::exportLayer(CALayer* gl_layer) {
  NSDictionary* dict = [[NSDictionary alloc] init];
  CGSConnectionID connection_id = CGSMainConnectionID();
  CAContext* remoteContext = [CAContext contextWithCGSConnection:connection_id options:dict];

  printf("Renderer: Setting the CAContext's layer to the CALayer to export\n");
  [remoteContext setLayer:gl_layer];

  printf("Renderer: Sending the ID of the context back to the server\n");
  CAContextID contextId = [remoteContext contextId];
  // Send the contextId to the HostApp
  ipc::Ipc::instance().write_data(&contextId);
}
