// *********************************************************************************************************************
//   Module Name:  DNOrderedManagedObject.m
//   Description:  NSManagedObject subclass capable of maintaining an ordered relationship.
//   Author Name:  David F. Negrete
// *********************************************************************************************************************


#import "DNOrderedManagedObject.h"

#pragma mark Imports


#pragma mark - Constants
/// Constants used by the DNOrderedManagedObject class.
const struct DNOrderedManagedObjectConstants {
  __unsafe_unretained NSString *orderPrefix;                       ///< Prefix added to the ordered relationship key.
  __unsafe_unretained NSString *indexSuffix;                       ///< Suffix added to the sorting attribute key.
} DNOrderedManagedObjectConstants;

const struct DNOrderedManagedObjectConstants DNOrderedManagedObjectConstants = {
  .orderPrefix = @"ordered",
  .indexSuffix = @"Index",
};


#pragma mark - Class Extension
@interface DNOrderedManagedObject ()
@end


#pragma mark -
@implementation DNOrderedManagedObject


#pragma mark - Lifecycle
// *********************************************************************************************************************
// - awakeFromInsert
// *********************************************************************************************************************
- (void)awakeFromInsert {
  [super awakeFromInsert];
  
  for( NSString *aKey in [self orderedKeys] ) {
    [self setPrimitiveOrderedValue:[NSMutableArray array] forKey:aKey];
  }
}

// *********************************************************************************************************************
// - awakeFromFetch
// *********************************************************************************************************************
- (void) awakeFromFetch {
  [super awakeFromFetch];
  
  for( NSString *aKey in [self orderedKeys] ) {
    [self setPrimitiveOrderedValue:[[self arrayFromRelationshipKey:aKey] mutableCopy] forKey:aKey];
  }
}


#pragma mark - Key-Value Observing
// *********************************************************************************************************************
// + keyPathsForValuesAffectingValueForKey:
// *********************************************************************************************************************
+ (NSSet*) keyPathsForValuesAffectingValueForKey:(NSString*)key
{
  NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
  
  if( [key hasPrefix:DNOrderedManagedObjectConstants.orderPrefix] ) {
    NSString *unorderedKey = [[key stringByRemovingOccurrencesOfString:DNOrderedManagedObjectConstants.orderPrefix]
                              stringWithLowercaseFirstLetter];
    keyPaths = [keyPaths setByAddingObject:unorderedKey];
  }
  
  return keyPaths;
}

// *********************************************************************************************************************
// + automaticallyNotifiesObserversForKey:
// *********************************************************************************************************************
+ (BOOL) automaticallyNotifiesObserversForKey:(NSString*)key
{
  if( [key hasPrefix:DNOrderedManagedObjectConstants.orderPrefix] ) {
    return NO;
  }
  
  return [super automaticallyNotifiesObserversForKey:key];
}


#pragma mark - Class Methods
// *********************************************************************************************************************
// + orderingKeyForRelationshipKey:
// *********************************************************************************************************************
+ (NSString*) orderingKeyForRelationshipKey:(NSString*)key
{
  return [DNOrderedManagedObjectConstants.orderPrefix stringByAppendingString:[key stringByCapitalizingFirstLetter]];
}

// *********************************************************************************************************************
// + orderingIndexForRelationshipKey:
// *********************************************************************************************************************
+ (NSString*) orderingIndexForRelationshipKey:(NSString*)key
{
  return [[self orderingKeyForRelationshipKey:key] stringByAppendingString:DNOrderedManagedObjectConstants.indexSuffix];
}


#pragma mark - Interface (Accessors)
// *********************************************************************************************************************
// - primitiveOrderedValueForKey:
// *********************************************************************************************************************
- (NSMutableArray*) primitiveOrderedValueForKey:(NSString*)key
{
  return [self primitiveValueForKey:[self orderingKeyForRelationshipKey:key]];
}

// *********************************************************************************************************************
// - setPrimitiveOrderedValue: forKey:
// *********************************************************************************************************************
- (void) setPrimitiveOrderedValue:(NSMutableArray*)value forKey:(NSString*)key
{
  [self setPrimitiveValue:value forKey:[self orderingKeyForRelationshipKey:key]];
}

// *********************************************************************************************************************
// - orderedValueForKey:
// *********************************************************************************************************************
- (NSArray*) orderedValueForKey:(NSString*)key
{  
  return [self valueForKey:[self orderingKeyForRelationshipKey:key]];
}

// *********************************************************************************************************************
// - setOrderedValue: forKey:
// *********************************************************************************************************************
- (void) setOrderedValue:(NSArray*)value forKey:(NSString*)key
{
  [self setValue:[value mutableCopy] forKey:[self orderingKeyForRelationshipKey:key]];
}


#pragma mark - Interface (Modifiers)
// *********************************************************************************************************************
// - objectInOrderedValueAtIndex: forKey:
// *********************************************************************************************************************
- (NSManagedObject*) objectInOrderedValueAtIndex:(NSUInteger)index forKey:(NSString*)key
{
  return [[self orderedValueForKey:key] objectAtIndex:index];
}

// *********************************************************************************************************************
// - indexOfObject: inOrderedValueForKey:
// *********************************************************************************************************************
- (NSUInteger) indexOfObject:(NSManagedObject*)anObject inOrderedValueForKey:(NSString*)key
{
  return [[self orderedValueForKey:key] indexOfObject:anObject];
}

// *********************************************************************************************************************
// - addObject: toOrderedValueForKey:
// *********************************************************************************************************************
- (void) addObject:(NSManagedObject*)anObject toOrderedValueForKey:(NSString*)key
{
  [self insertObject:anObject inOrderedValueAtIndex:[self countOfOrderedValueForKey:key] forKey:key];
}

// *********************************************************************************************************************
// - insertObject: inOrderedValueAtIndex: forKey:
// *********************************************************************************************************************
- (void) insertObject:(NSManagedObject*)anObject inOrderedValueAtIndex:(NSUInteger)index forKey:(NSString*)key
{
  [(NSMutableArray*)[self orderedValueForKey:key] insertObject:anObject atIndex:index];
  
  [self reorderObjectsForKey:key fromIndex:index toIndex:[self countOfOrderedValueForKey:key]];
  
  [[self mutableSetValueForKey:key] addObject:anObject];
}

// *********************************************************************************************************************
// - removeObjectFromOrderedValueAtIndex: forKey:
// *********************************************************************************************************************
- (void) removeObjectFromOrderedValueAtIndex:(NSUInteger)index forKey:(NSString*)key
{
  NSManagedObject *theObject = [self objectInOrderedValueAtIndex:index forKey:key];

  [(NSMutableArray*)[self orderedValueForKey:key] removeObjectAtIndex:index];

  [[self mutableSetValueForKey:key] removeObject:theObject];

  [self reorderObjectsForKey:key fromIndex:index toIndex:[self countOfOrderedValueForKey:key]-1];
}

// *********************************************************************************************************************
// - moveObjectFromOrderedValueAtIndex: toIndex: forKey:
// *********************************************************************************************************************
- (void) moveObjectFromOrderedValueAtIndex:(NSUInteger)index1 toIndex:(NSUInteger)index2 forKey:(NSString*)key
{
  [self willChangeValueForKey:[self orderingKeyForRelationshipKey:key]];

  [(NSMutableArray*)[self orderedValueForKey:key] moveObjectAtIndex:index1 toIndex:index2];

  [self reorderObjectsForKey:key
                   fromIndex:index1 < index2 ? index1 : index2
                     toIndex:index1 > index2 ? index1 : index2];
  
  [self didChangeValueForKey:[self orderingKeyForRelationshipKey:key]];
}

// *********************************************************************************************************************
// - countOfOrderedValueForKey:
// *********************************************************************************************************************
- (NSUInteger) countOfOrderedValueForKey:(NSString*)key
{
  return [[self valueForKey:key] count];
}

// *********************************************************************************************************************
// - updateOrderedValueForKey: with:
// *********************************************************************************************************************
- (void) updateOrderedValueForKey:(NSString*)key with:(void(^)(NSMutableArray *orderedValue))updateBlock
{
  NSMutableArray *orderedObjects = (NSMutableArray*)[self orderedValueForKey:key];
  updateBlock(orderedObjects);
  [self setPrimitiveOrderedValue:orderedObjects forKey:key];
}


#pragma mark - Convenience
// *********************************************************************************************************************
// - orderingKeyForRelationshipKey:
// *********************************************************************************************************************
- (NSString*) orderingKeyForRelationshipKey:(NSString*)key
{
  return [[self class] orderingKeyForRelationshipKey:key];
}

// *********************************************************************************************************************
// - orderingIndexForRelationshipKey:
// *********************************************************************************************************************
- (NSString*) orderingIndexForRelationshipKey:(NSString*)key
{
  return [[self class] orderingIndexForRelationshipKey:key];
}

// *********************************************************************************************************************
// - orderedKeys
// *********************************************************************************************************************
- (NSArray*) orderedKeys
{
  NSMutableArray *result = [NSMutableArray array];
  NSDictionary *availableProperties = [[self entity] propertiesByName];
  
  for( NSString *relation in [[self entity] relationshipsByName] ) {
    if( [availableProperties valueForKey:[self orderingKeyForRelationshipKey:relation]] ) {
      [result addObject:relation];
    }
  }
  
  return result;
}


#pragma mark - Private Methods
// *********************************************************************************************************************
// - arrayFromRelationshipKey:
// *********************************************************************************************************************
- (NSArray*) arrayFromRelationshipKey:(NSString*)key
{
  NSSet *objects = [self valueForKey:key];
  NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey:[self orderingIndexForRelationshipKey:key]
                                                       ascending:YES];
  NSArray *sortDescriptors = @[sd];
  
  return [objects sortedArrayUsingDescriptors:sortDescriptors];
}

// *********************************************************************************************************************
// - reorderObjectsForKey: fromIndex: toIndex: offset:
// *********************************************************************************************************************
- (void) reorderObjectsForKey:(NSString*)key
                    fromIndex:(NSUInteger)index1
                      toIndex:(NSUInteger)index2
                       offset:(NSUInteger)offset
{
  NSRange reorderRange = NSMakeRange(index1, index2 - index1 + 1);
  NSArray *sortedObjects = [self orderedValueForKey:key];
  NSUInteger currentIndex = index1;
  
  for( NSManagedObject *anObject in [sortedObjects subarrayWithRange:reorderRange] ) {
    [anObject setValue:@(currentIndex+offset) forKey:[self orderingIndexForRelationshipKey:key]];
    currentIndex++;
  }
}

// *********************************************************************************************************************
// - reorderObjectsForKey: fromIndex: toIndex:
// *********************************************************************************************************************
- (void) reorderObjectsForKey:(NSString*)key fromIndex:(NSUInteger)index1 toIndex:(NSUInteger)index2
{
  [self reorderObjectsForKey:key fromIndex:index1 toIndex:index2 offset:0];
}


#pragma mark - Dynamic Method Resolution
// *********************************************************************************************************************
// + resolveInstanceMethod:
// *********************************************************************************************************************
+ (BOOL) resolveInstanceMethod:(SEL)aSEL
{
  NSString *selectorName = NSStringFromSelector(aSEL);
  SEL concreteSEL = nil;

  if( [selectorName substringBetweenString:@"addObjectToOrdered" andString:@":"] ) {
    concreteSEL = @selector(addObjectToOrderedKey:);
  }
  else if( [selectorName substringBetweenString:@"insertObject:inOrdered" andString:@"AtIndex:"] ) {
    concreteSEL = @selector(insertObject:inOrderedKeyAtIndex:);
  }
  else if( [selectorName substringBetweenString:@"objectInOrdered" andString:@"AtIndex:"] ) {
//TODO:    concreteSEL = @selector(objectInOrderedKeyAtIndex:);
  }
  else if( [selectorName substringBetweenString:@"indexOfObjectInOrdered" andString:@":"] ) {
    concreteSEL = @selector(indexOfObjectInOrderedKey:);
  }
  else if( [selectorName substringBetweenString:@"removeObjectFromOrdered" andString:@"AtIndex:"] ) {
    concreteSEL = @selector(removeObjectFromOrderedKeyAtIndex:);
  }
  else if( [selectorName hasPrefix:@"countOfOrdered"] ) {
    concreteSEL = @selector(countOfOrderedKey);
  }
  
  if( concreteSEL ) {
    return [self synthesizeSEL:aSEL withSEL:concreteSEL];
  }

  return [super resolveInstanceMethod:aSEL];
}


#pragma mark - Dynamic Methods
// *********************************************************************************************************************
// - addObjectToOrderedKey:
// *********************************************************************************************************************
- (void) addObjectToOrderedKey:(NSManagedObject*)anObject
{
  NSString *selectorName = NSStringFromSelector(_cmd);
  NSString *key = [[selectorName substringBetweenString:@"addObjectToOrdered" andString:@":"]
                   stringWithLowercaseFirstLetter];

  [self addObject:anObject toOrderedValueForKey:key];
}

// *********************************************************************************************************************
// - insertObject: inOrderedKeyAtIndex:
// *********************************************************************************************************************
- (void) insertObject:(NSManagedObject*)anObject inOrderedKeyAtIndex:(NSUInteger)index
{
  NSString *selectorName = NSStringFromSelector(_cmd);
  NSString *key = [[selectorName substringBetweenString:@"insertObject:inOrdered" andString:@"AtIndex:"]
                   stringWithLowercaseFirstLetter];

  [self insertObject:anObject inOrderedValueAtIndex:index forKey:key];
}

// *********************************************************************************************************************
// - objectInOrderedKeyAtIndex:
// *********************************************************************************************************************
- (NSManagedObject*) objectInOrderedKeyAtIndex:(NSUInteger)index
{
  NSString *selectorName = NSStringFromSelector(_cmd);
  NSString *key = [[selectorName substringBetweenString:@"objectInOrdered" andString:@"AtIndex:"]
                   stringWithLowercaseFirstLetter];

  return [self objectInOrderedValueAtIndex:index forKey:key];
}

// *********************************************************************************************************************
// - indexOfObjectInOrderedKey:
// *********************************************************************************************************************
- (NSUInteger) indexOfObjectInOrderedKey:(id)anObject
{
  NSString *selectorName = NSStringFromSelector(_cmd);
  NSString *key = [[selectorName substringBetweenString:@"indexOfObjectInOrdered" andString:@":"]
                   stringWithLowercaseFirstLetter];

  return [self indexOfObject:anObject inOrderedValueForKey:key];
}

// *********************************************************************************************************************
// - removeObjectFromOrderedKeyAtIndex:
// *********************************************************************************************************************
- (void) removeObjectFromOrderedKeyAtIndex:(NSUInteger)index
{
  NSString *selectorName = NSStringFromSelector(_cmd);
  NSString *key = [[selectorName substringBetweenString:@"removeObjectFromOrdered" andString:@"AtIndex:"]
                   stringWithLowercaseFirstLetter];

  [self removeObjectFromOrderedValueAtIndex:index forKey:key];
}

// *********************************************************************************************************************
// - countOfOrderedKey
// *********************************************************************************************************************
- (NSUInteger) countOfOrderedKey
{
  NSString *selectorName = NSStringFromSelector(_cmd);
  NSString *key = [[selectorName stringByRemovingOccurrencesOfString:@"countOfOrdered"] stringWithLowercaseFirstLetter];

  return [self countOfOrderedValueForKey:key];
}


@end
