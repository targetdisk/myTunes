#import <AppKit/AppKit.h>

#import "AppDelegate.h"
#import "Library.h"
#import "Menu.h"

@implementation AppController
NSApplication *_app;
NSMenu *_menu;
Library *library;
MenuController *menuc;

- (id)initWithNSApp:(NSApplication *)app
{
  if ((self = [super init]))
  {
    _app = app;
  }
  return self;
}

- (void) applicationWillFinishLaunching: (NSNotification *)notif
{
  library = [[Library alloc]init];

  CFStringRef library_path = (CFStringRef)CFPreferencesCopyAppValue(
      CFSTR("library path"), kCFPreferencesCurrentApplication);

  if (!library_path)
  {
    NSString *defaultPath = [NSString stringWithFormat:@"%@/Music/myTunes", NSHomeDirectory()];
    CFPreferencesSetAppValue(CFSTR("library path"),
        (CFStringRef)defaultPath,
        kCFPreferencesCurrentApplication);

    CFPreferencesAppSynchronize(kCFPreferencesCurrentApplication);
  }

  if (![library load_library: (NSString *)library_path])
  {
    NSError *error;

    if (![[NSFileManager defaultManager]
        createDirectoryAtPath:(NSString *)library_path
  withIntermediateDirectories:YES
                   attributes:nil
                        error:&error
         ])
    {
      NSAlert *alert = [[NSAlert alloc] init];

      [alert setMessageText:[error localizedDescription]];
      [alert setInformativeText:[error localizedFailureReason]];
      [alert addButtonWithTitle:@"Quit"];
      [alert setAlertStyle:NSCriticalAlertStyle];

      [alert runModal];

      [NSApp terminate:self];
    }
  }

  CFRelease(library_path);

  menuc = [[MenuController alloc] init];
  [menuc createMenu];
}

- (void)applicationDidFinishLaunching:(NSNotification *)notif
{
  NSLog(@"hello!\n");
}
@end
