// *********************************************************************************************************************
//   Module Name:  NSMutableArray+DNExtras.m
//   Description:  NSMutableArray Category.
//   Author Name:  David F. Negrete
// *********************************************************************************************************************
//   Date         Description
//   ----------   ----------------------------------------------------------------------------------------------------
//   2012.09.13   Initial Creation.
// *********************************************************************************************************************


#import "NSMutableArray+DNExtras.h"


@implementation NSMutableArray(DNExtras)


// *********************************************************************************************************************
// - moveObjectAtIndex: toIndex:
// *********************************************************************************************************************
- (void) moveObjectAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
  if( fromIndex != toIndex ) {
    id anObject = self[fromIndex];
    
    [self removeObjectAtIndex:fromIndex];
    
    if( toIndex > fromIndex ) {
      toIndex--;
    }
    
    [self insertObject:anObject atIndex:toIndex];
  }
}


@end

