// *********************************************************************************************************************
//   Module Name:  NSManagedObjectContext+DNDynamic.m
//   Description:  NSManagedObjectContext category.
//   Author Name:  David F. Negrete
// *********************************************************************************************************************


#import "NSManagedObjectContext+DNDynamic.h"


#pragma mark - Constants
const struct NSManagedObjectContextDynamicMethod {
  __unsafe_unretained NSString *entitySingle;
  __unsafe_unretained NSString *entityEvery;
  __unsafe_unretained NSString *entityCount;
  __unsafe_unretained NSString *predicate;
  __unsafe_unretained NSString *order;
} NSManagedObjectContextDynamicMethod;

const struct NSManagedObjectContextDynamicMethod NSManagedObjectContextDynamicMethod = {
  .entitySingle = @"fetchThe",
  .entityEvery = @"fetchEvery",
  .entityCount = @"countEvery",
  .predicate = @"With",
  .order = @"SortedBy",
};


@implementation NSManagedObjectContext (DNDynamicSetup)


#pragma mark - Dynamic Resolution
// *********************************************************************************************************************
// + resolveInstanceMethod:
// *********************************************************************************************************************
+ (BOOL) resolveInstanceMethod:(SEL)aSEL
{
  if( ([NSStringFromSelector(aSEL) hasPrefix:NSManagedObjectContextDynamicMethod.entityEvery]) ||
     ([NSStringFromSelector(aSEL) hasPrefix:NSManagedObjectContextDynamicMethod.entitySingle]) ||
     ([NSStringFromSelector(aSEL) hasPrefix:NSManagedObjectContextDynamicMethod.entityCount]) )
  {
    return [self resolveDynamicMethod:aSEL];
  }

  return [super resolveInstanceMethod:aSEL];
}

// *********************************************************************************************************************
// + resolveDynamicMethod:
// *********************************************************************************************************************
+ (BOOL) resolveDynamicMethod:(SEL)dynamicSEL
{
  NSString *selectorName = NSStringFromSelector(dynamicSEL);
  SEL concreteSEL;
  
  if( [selectorName substringBetweenString:NSManagedObjectContextDynamicMethod.entityCount
                                 andString:NSManagedObjectContextDynamicMethod.predicate] ) {
    concreteSEL = @selector(countEveryWith:);
  }
  else if( [selectorName hasPrefix:NSManagedObjectContextDynamicMethod.entityCount] ) {
    concreteSEL = @selector(countEvery);
  }
  else if( [selectorName substringBetweenString:NSManagedObjectContextDynamicMethod.entityEvery
                                 andString:NSManagedObjectContextDynamicMethod.predicate] ) {
    concreteSEL = @selector(fetchEveryWith:);
  }
  else if( [selectorName substringBetweenString:NSManagedObjectContextDynamicMethod.entitySingle
                                      andString:NSManagedObjectContextDynamicMethod.predicate] ) {
    concreteSEL = @selector(fetchTheWith:);
  }
  else if( [selectorName substringBetweenString:NSManagedObjectContextDynamicMethod.entityEvery
                                      andString:NSManagedObjectContextDynamicMethod.order] ) {
    concreteSEL = @selector(fetchEverySortedBy:);
  }
  else {
    concreteSEL = @selector(fetchEvery);
  }
  
  return [self synthesizeSEL:dynamicSEL withSEL:concreteSEL];
}


#pragma mark - Dynamic-to-Concrete
// *********************************************************************************************************************
// - countEvery
// *********************************************************************************************************************
- (NSUInteger) countEvery
{
  NSString *selectorName = NSStringFromSelector(_cmd);
  NSString *entityName = [selectorName substringFromIndex:[NSManagedObjectContextDynamicMethod.entityEvery length]];
  
  return [self countObjectsForEntityForName:entityName predicate:nil];
}

// *********************************************************************************************************************
// - countEveryWith:
// *********************************************************************************************************************
- (NSUInteger) countEveryWith:(id)keyValue
{
  NSString *selectorName = NSStringFromSelector(_cmd);
  NSString *entityName = [selectorName substringBetweenString:NSManagedObjectContextDynamicMethod.entityCount
                                                    andString:NSManagedObjectContextDynamicMethod.predicate];
  NSString *keyName = [[selectorName substringBetweenString:NSManagedObjectContextDynamicMethod.predicate
                                                  andString:@":"]
                       stringWithLowercaseFirstLetter];
  
  NSPredicate *pred = [NSPredicate predicateWithFormat:@"%K == %@", keyName, keyValue];
  
  return [self countObjectsForEntityForName:entityName predicate:pred];
}

// *********************************************************************************************************************
// - fetchEvery
// *********************************************************************************************************************
- (NSSet*) fetchEvery
{
  NSString *selectorName = NSStringFromSelector(_cmd);
  NSString *entityName = [selectorName substringFromIndex:[NSManagedObjectContextDynamicMethod.entityEvery length]];

  return [self fetchObjectsForEntityForName:entityName];
}

// *********************************************************************************************************************
// - fetchEveryWith:
// *********************************************************************************************************************
- (NSSet*) fetchEveryWith:(id)keyValue
{
  NSString *selectorName = NSStringFromSelector(_cmd);
  NSString *entityName = [selectorName substringBetweenString:NSManagedObjectContextDynamicMethod.entityEvery
                                                    andString:NSManagedObjectContextDynamicMethod.predicate];
  NSString *keyName = [[selectorName substringBetweenString:NSManagedObjectContextDynamicMethod.predicate
                                                  andString:@":"]
                       stringWithLowercaseFirstLetter];

  NSPredicate *pred = [NSPredicate predicateWithFormat:@"%K == %@", keyName, keyValue];

  return [self fetchObjectsForEntityForName:entityName predicate:pred];
}

// *********************************************************************************************************************
// - fetchTheWith:
// *********************************************************************************************************************
- (id) fetchTheWith:(id)keyValue
{
  NSString *selectorName = NSStringFromSelector(_cmd);
  NSString *entityName = [selectorName substringBetweenString:NSManagedObjectContextDynamicMethod.entitySingle
                                                    andString:NSManagedObjectContextDynamicMethod.predicate];
  NSString *keyName = [[selectorName substringBetweenString:NSManagedObjectContextDynamicMethod.predicate
                                                  andString:@":"]
                       stringWithLowercaseFirstLetter];

  NSPredicate *pred = [NSPredicate predicateWithFormat:@"%K == %@", keyName, keyValue];

  NSSet *results = [self fetchObjectsForEntityForName:entityName predicate:pred];

  if( results.count == 0 ) {
    return nil;
  } else if( results.count > 1 ) {
    @throw([NSException exceptionWithName:@"Retrieved multiple objects"
                                   reason:[NSString stringWithFormat:@"Error when calling %@", selectorName]
                                 userInfo:nil]);
  }

  return [results anyObject];
}

// *********************************************************************************************************************
// - fetchEverySortedBy:
// *********************************************************************************************************************
- (NSArray*) fetchEverySortedBy:(BOOL)ascending
{
  NSString *selectorName = NSStringFromSelector(_cmd);
  NSString *entityName = [selectorName substringBetweenString:NSManagedObjectContextDynamicMethod.entityEvery
                                                    andString:NSManagedObjectContextDynamicMethod.order];
  NSString *keyName = [[selectorName substringBetweenString:NSManagedObjectContextDynamicMethod.order
                                                  andString:@":"]
                       stringWithLowercaseFirstLetter];

  return [self fetchObjectsForEntityForName:entityName sortBy:keyName ascending:ascending predicate:nil limit:0];
}


@end
