// *********************************************************************************************************************
//   Module Name:  NSDictionary+DNExtras.m
//   Description:  NSDictionary category.
//   Author Name:  David F. Negrete
// *********************************************************************************************************************


#import "NSDictionary+DNExtras.h"


@implementation NSDictionary (DNExtras)


// *********************************************************************************************************************
// - each:
// *********************************************************************************************************************
- (void) each:(void(^)(id key, id value))eachBlock
{
  NSArray *keys = [self allKeys];
  
  for( id aKey in keys ) {
    eachBlock(aKey, self[aKey]);
  }
}


@end
