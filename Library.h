#import <AppKit/AppKit.h>

@interface Library: NSObject
{}
 @property(copy, readwrite) id libraryPlist;

- (bool)load_library:(NSString *)path;
@end
