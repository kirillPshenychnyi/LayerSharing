#include "server_app.h"
#include "app_delegate.h"
#include "ipc/ipc.h"
#include "rendering/remote_layer_api.h"
#include "rendering/server_main_window.h"

void ServerApp::run(int windows_count) {
  [NSApplication sharedApplication];

  [NSApp setDelegate: [AppDelegate new]];
  [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];

  NSMenu* menubar = [NSMenu alloc];
  [NSApp setMainMenu:menubar];

  initWindows(windows_count);

  [NSApp activateIgnoringOtherApps:YES];
  [NSApp run];
}

void ServerApp::initWindows(int windows_count) {
  for (int i = 0; i < windows_count; ++i) {
    ServerMainWindow* window = [[ServerMainWindow alloc]
        initWithContentRect:NSMakeRect(40*i, 40*i, 480, 480)
                  styleMask:NSTitledWindowMask
                    backing:NSBackingStoreBuffered
                      defer:NO];

    [window setTitle:@"CARemoteLayer Example"];
    [window makeKeyAndOrderFront:nil];

    NSView* view = [window contentView];
    [view setWantsLayer:YES];

    CALayerHost* layer_host = getLayerHost();

    [[[window contentView] layer] addSublayer:layer_host];
    [layer_host setPosition:CGPointMake(240, 240)];
    printf("Server: Added the layer to the view hierarchy..\n");
  }
}

CALayerHost* ServerApp::getLayerHost() {
    CAContextID context_id = 0;
    ipc::Ipc::instance().read_data(&context_id);
    printf("Server: Read the context ID and creating a CALayerHost using it\n");
    CALayerHost* layer_host = [[CALayerHost alloc] init];
    [layer_host setContextId:context_id];
    return layer_host;
}
