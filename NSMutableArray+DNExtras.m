// *********************************************************************************************************************
//   Module Name:  NSMutableArray+DNExtras.m
//   Description:  NSMutableArray category.
//   Author Name:  David F. Negrete
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
    [self insertObject:anObject atIndex:toIndex];
  }
}

// *********************************************************************************************************************
// - select:
// *********************************************************************************************************************
- (void) select:(BOOL(^)(id arrayObject))selectBlock
{
  [self reject:^BOOL(id anObject) {
    return !selectBlock(anObject);
  }];
}

// *********************************************************************************************************************
// - reject:
// *********************************************************************************************************************
- (void) reject:(BOOL(^)(id arrayObject))rejectBlock
{
  NSMutableIndexSet *indexesOfRejected = [NSMutableIndexSet indexSet];
  
  NSUInteger objectIndex = 0;
  for( id anObject in self ) {
    if( rejectBlock(anObject) ) {
      [indexesOfRejected addIndex:objectIndex];
    }
    objectIndex++;
  }
  
  [self removeObjectsAtIndexes:indexesOfRejected];
}


@end
