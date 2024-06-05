#import <AppKit/AppKit.h>

#import "Menu.h"

@implementation MenuController
  NSMenu *menubar;

- (void)createMenu
{
  menubar = [[NSMenu alloc]init];
  [NSApp setMainMenu:menubar];

  NSMenuItem *appMenuItem = [[NSMenuItem alloc] init];
  [menubar addItem:appMenuItem];
  NSMenu *appMenu = [[NSMenu alloc] init];

  [appMenu addItem: [[NSMenuItem alloc]
     initWithTitle: [NSString stringWithFormat:@"About %@", [[NSProcessInfo processInfo] processName]]
            action:@selector(orderFrontStandardAboutPanel:)
                     keyEquivalent:@""]
  ];

  [appMenu addItem: [NSMenuItem separatorItem]];

  [appMenu addItem: [[NSMenuItem alloc]
     initWithTitle:@"Preferences"
            action:@selector(preferences:)
     keyEquivalent:@""
  ]];

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
@end
