#import <AppKit/AppKit.h>

#import "Library.h"
#import "AppDelegate.h"

@implementation AppController
NSApplication *_app;
NSMenu *_menu;
Library *library;

- (id)initWithNSApp:(NSApplication *)app
{
  if ((self = [super init]))
  {
    _app = app;
  }
  return self;
}

- (void)createMenu
{
  NSMenu *menubar = [[NSMenu alloc]init];
  [NSApp setMainMenu:menubar];

  NSMenuItem *appMenuItem = [[NSMenuItem alloc] init];
  [menubar addItem:appMenuItem];
  NSMenu *appMenu = [[NSMenu alloc] init];

  [appMenu addItem: [[NSMenuItem alloc]
     initWithTitle: [NSString stringWithFormat:@"About %@", [[NSProcessInfo processInfo] processName]]
                     action:@selector(orderFrontStandardAboutPanel:)
                     keyEquivalent:@""]];
  [appMenu addItem: [NSMenuItem separatorItem]];
  [appMenu addItem: [[NSMenuItem alloc]
                     initWithTitle:@"Hide"
                     action:@selector(hide:)
                     keyEquivalent:@"h"]];
  [appMenu addItem: [NSMenuItem separatorItem]];
  [appMenu addItem: [[NSMenuItem alloc]
                     initWithTitle:@"Quit"
                     action:@selector(terminate:)
                     keyEquivalent:@"q"]];
  [appMenuItem setSubmenu:appMenu];
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

  [self createMenu];
}

- (void)applicationDidFinishLaunching:(NSNotification *)notif
{
  NSLog(@"hello!\n");
}
@end
