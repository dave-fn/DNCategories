// *********************************************************************************************************************
//   Module Name:  NSString+DNExtras.m
//   Description:  NSString category.
//   Author Name:  David F. Negrete
// *********************************************************************************************************************


#import "NSString+DNExtras.h"


@implementation NSString(DNExtras)


// *********************************************************************************************************************
// - stringByRemovingOccurrencesOfString:
// *********************************************************************************************************************
- (NSString*) stringByRemovingOccurrencesOfString:(NSString*)substring
{
  return [self stringByReplacingOccurrencesOfString:substring withString:@""];
}

// *********************************************************************************************************************
// - stringByRemovingOccurrencesOfStrings:
// *********************************************************************************************************************
- (NSString*) stringByRemovingOccurrencesOfStrings:(NSArray*)stringArray
{
  NSString *newString = self;
  
  for( NSString *stringToReplace in stringArray ) {
    newString = [newString stringByReplacingOccurrencesOfString:stringToReplace withString:@""];
  }
  
  return newString;
}

// *********************************************************************************************************************
// - stringByCapitalizingFirstLetter
// *********************************************************************************************************************
- (NSString*) stringByCapitalizingFirstLetter
{
  return [NSString stringWithFormat:@"%@%@",[[self substringToIndex:1] uppercaseString],[self substringFromIndex:1]];
}

// *********************************************************************************************************************
// - stringWithLowercaseFirstLetter
// *********************************************************************************************************************
- (NSString*) stringWithLowercaseFirstLetter
{
  return [NSString stringWithFormat:@"%@%@",[[self substringToIndex:1] lowercaseString],[self substringFromIndex:1]];
}

// *********************************************************************************************************************
// - substringBetweenString: andString:
// *********************************************************************************************************************
- (NSString*) substringBetweenString:(NSString*)firstString andString:(NSString*)secondString
{
  NSRange substringRange;
  
  // Find beginning point
  NSRange firstRange = [self rangeOfString:firstString];
  if( firstRange.location == NSNotFound ) {
    return nil;
  }
  substringRange.location = firstRange.location + firstRange.length;
  
  // Find ending point
  NSUInteger stringLength = [self length];
  NSRange splitStringRange = NSMakeRange(substringRange.location, stringLength - substringRange.location);
  NSRange secondRange = [self rangeOfString:secondString options:NULL range:splitStringRange];
  if( secondRange.location == NSNotFound ) {
    return nil;
  }
  
  // Make range with points
  substringRange.length = secondRange.location - substringRange.location;
  
  return [self substringWithRange:substringRange];
}


@end
