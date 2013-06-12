// *********************************************************************************************************************
//   Module Name:  NSArray+DNExtras.m
//   Description:  NSArray category.
//   Author Name:  David F. Negrete
// *********************************************************************************************************************


#import "NSArray+DNExtras.h"


@implementation NSArray (DNExtras)


// *********************************************************************************************************************
// - each:
// *********************************************************************************************************************
- (void) each:(void(^)(id arrayObject))eachBlock;
{
  for( id anObject in self ) {
    eachBlock(anObject);
  }
}

// *********************************************************************************************************************
// - map:
// *********************************************************************************************************************
- (NSArray*) map:(id(^)(id arrayObject))mapBlock
{
  NSMutableArray *mappedArray = [NSMutableArray arrayWithCapacity:self.count];
  
  for( id anObject in self) {
    id mappedObject = mapBlock(anObject);
    [mappedArray addObject:mappedObject ? mappedObject : [NSNull null]];
  }
  
  return [NSArray arrayWithArray:mappedArray];
}

// *********************************************************************************************************************
// - arrayBySelecting:
// *********************************************************************************************************************
- (NSArray*) arrayBySelecting:(BOOL(^)(id arrayObject))selectBlock
{
  NSMutableArray *filteredArray = [NSMutableArray arrayWithCapacity:self.count];
  
  for( id anObject in self) {
    if( selectBlock(anObject) ) {
      [filteredArray addObject:anObject];
    }
  }
  
  return [NSArray arrayWithArray:filteredArray];
}

// *********************************************************************************************************************
// - arrayByRejecting:
// *********************************************************************************************************************
- (NSArray*) arrayByRejecting:(BOOL(^)(id arrayObject))rejectBlock
{
  return [self arrayBySelecting:^BOOL(id anObject) {
    return !rejectBlock(anObject);
  }];
}


@end
