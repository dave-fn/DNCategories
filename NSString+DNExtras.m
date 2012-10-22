// *********************************************************************************************************************
//   Module Name:  NSString+DNExtras.m
//   Description:  NSString Category.
//   Author Name:  David F. Negrete
// *********************************************************************************************************************
//   Date         Description
//   ----------   ----------------------------------------------------------------------------------------------------
//   2012.08.14   Initial Creation.
// *********************************************************************************************************************


#import "NSString+DNExtras.h"


@implementation NSString(DNExtras)


// *********************************************************************************************************************
//  - stringByRemovingOccurrencesOfStrings:
// *********************************************************************************************************************
- (NSString*) stringByRemovingOccurrencesOfStrings:(NSArray*)stringArray
{
  NSString *newString = self;
  
  for(NSString *stringToReplace in stringArray ) {
    newString = [newString stringByReplacingOccurrencesOfString:stringToReplace withString:@""];
  }
  
  return newString;
}


// *********************************************************************************************************************
//  - stringByCapitalizingFirstLetter
// *********************************************************************************************************************
- (NSString*) stringByCapitalizingFirstLetter
{
  return [NSString stringWithFormat:@"%@%@",[[self substringToIndex:1] uppercaseString],[self substringFromIndex:1]];
}


// *********************************************************************************************************************
//  - stringWithLowercaseFirstLetter
// *********************************************************************************************************************
- (NSString*) stringWithLowercaseFirstLetter
{
  return [NSString stringWithFormat:@"%@%@",[[self substringToIndex:1] lowercaseString],[self substringFromIndex:1]];
}



@end

