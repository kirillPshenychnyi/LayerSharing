#import "server_main_window.h"
#include "ipc/ipc.h"

@implementation ServerMainWindow

- (void)keyDown:(NSEvent *)event {
  if (![event isARepeat]) {
    NSString *characters = [event charactersIgnoringModifiers];
    if ([characters length] == 1 && [characters characterAtIndex:0] == 'q') {
      printf("Server: Killing off the client and quitting\n");
      ipc::Ipc::instance().terminate();
      [NSApp terminate:nil];
    }
  }
}

@end
