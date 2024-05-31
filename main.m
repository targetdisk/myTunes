#import <AppKit/AppKit.h>

#import "AppDelegate.h"

int main (int argc, const char *argv[])
{
  NSAutoreleasePool *pool = [NSAutoreleasePool new];

  NSApplication *app = [NSApplication sharedApplication];
  [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];

  id controller = [[AppController alloc] initWithNSApp:app];
  [NSApp setDelegate:controller];
  [NSApp activateIgnoringOtherApps:YES];

  [NSApp run];

  [pool release];

  return 0;
}
