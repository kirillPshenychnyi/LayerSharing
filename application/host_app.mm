#include "host_app.h"
#include "app_delegate.h"
#include "rendering/server_main_window.h"

void HostApp::run(int windows_count) {
  [NSApplication sharedApplication];

  [NSApp setDelegate: [AppDelegate new]];
  [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];

  NSMenu* menubar = [NSMenu alloc];
  [NSApp setMainMenu:menubar];

  initWindows(windows_count);

  [NSApp activateIgnoringOtherApps:YES];
  [NSApp run];
}

void HostApp::initWindows(int windows_count) {
  for (int i = 0; i < windows_count; ++i) {
    ServerMainWindow* window = [[ServerMainWindow alloc]
        initWithContentRect:NSMakeRect(40*i, 40*i, 480, 480)
                  styleMask:NSTitledWindowMask
                    backing:NSBackingStoreBuffered
                      defer:NO];

    [window setTitle:[NSString stringWithFormat:@"CARemoteLayer window #%d",
                                                i+1]];
    [window makeKeyAndOrderFront:nil];

    NSView* view = [window contentView];
    [view setWantsLayer:YES];

    CALayerHost* layer_host = getLayerHost();

    [[[window contentView] layer] addSublayer:layer_host];
    [layer_host setPosition:CGPointMake(240, 240)];
    printf("Host: Added the layer to the view hierarchy..\n");
  }
}

CALayerHost*HostApp::getLayerHost() {
    if (context_id_ == 0) {
      ipc::Ipc::instance().read_data(&context_id_);
    }
    printf("Server: Read the context ID and creating a CALayerHost using it\n");
    CALayerHost* layer_host = [[CALayerHost alloc] init];
    [layer_host setContextId:context_id_];
    return layer_host;
}
