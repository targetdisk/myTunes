#import <AppKit/AppKit.h>
#include <stdlib.h>

#import "Library.h"

@implementation Library
NSPropertyListFormat format;
id libraryPlist;

static NSData *libraryPlistData;
static NSString *error;

- (bool)load_library:(NSString *)path;
{
  libraryPlistData = [NSData dataWithContentsOfFile:path];

  libraryPlist = [NSPropertyListSerialization
    propertyListFromData:libraryPlistData
        mutabilityOption:NSPropertyListMutableContainersAndLeaves
                  format:&format
        errorDescription:&error
  ];

  if (!libraryPlist)
  {
    NSLog(@"%@", error);
    [error release];

    return false;
  }

  return true;
}

@synthesize libraryPlist;
@end
