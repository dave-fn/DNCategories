// *********************************************************************************************************************
//   Module Name:  NSFileManager+DNExtras.m
//   Description:  NSFileManager category.
//   Author Name:  David F. Negrete
// *********************************************************************************************************************


#import "NSFileManager+DNExtras.h"


@implementation NSFileManager (DNExtras)


// *********************************************************************************************************************
// - applicationSupportDirectory
// *********************************************************************************************************************
- (NSString*) applicationSupportDirectory
{
  return [[self applicationSupportDirectoryURL] path];
}

// *********************************************************************************************************************
// - applicationSupportDirectoryURL
// *********************************************************************************************************************
- (NSURL*) applicationSupportDirectoryURL
{
  NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
  
  NSError *error = nil;
  NSURL *appSupportURL = [self applicationSupportURLOfApplication:appName error:&error];
  
  if( !appSupportURL ) {
    NSLog(@"Unable to find or create app support directory\n%@", error);
  }
  
  return appSupportURL;
}

// *********************************************************************************************************************
// - applicationSupportURLOfApplication: error:
// *********************************************************************************************************************
- (NSURL*) applicationSupportURLOfApplication:(NSString*)appName error:(NSError**)error
{
  if( !appName || [appName isEqualToString:@""] ) {
    NSDictionary *dict = @{NSLocalizedDescriptionKey: @"No name given"};
    *error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:101 userInfo:dict];
    return nil;
  }
  
  NSArray *urls = [self URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask];
  NSURL *appSupportURL = urls[0];
  appSupportURL = [appSupportURL URLByAppendingPathComponent:appName];
  
  NSError *resourceError = nil;
  NSDictionary *properties = [appSupportURL resourceValuesForKeys:@[NSURLIsDirectoryKey] error:&resourceError];
  
  if( properties && ![properties[NSURLIsDirectoryKey] boolValue] ) {
    NSString *failureDescription = [NSString stringWithFormat:@"Expected folder to store appl data, found file (%@).",
                                    [appSupportURL path]];
    NSDictionary *dict = @{NSLocalizedDescriptionKey: failureDescription};
    
    *error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:101 userInfo:dict];
    return nil;
  }
  
  if( !properties && ([resourceError code] == NSFileReadNoSuchFileError) ) {
    NSError *createError;
    BOOL createdDirectory = [self createDirectoryAtPath:[appSupportURL path]
                            withIntermediateDirectories:YES
                                             attributes:nil
                                                  error:&createError];
    
    if( !createdDirectory ) {
      *error = createError;
      return nil;
    }
  }
  
  *error = nil;
  return appSupportURL;
}


@end
