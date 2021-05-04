#import "app_delegate.h"
#import "ipc/ipc.h"

@implementation AppDelegate

  - (void)applicationWillTerminate:(NSNotification *)aNotification {
      ipc::Ipc::instance().terminate();
  }
  @end