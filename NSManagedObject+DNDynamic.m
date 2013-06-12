// *********************************************************************************************************************
//   Module Name:  NSManagedObject+DNDynamic.m
//   Description:  NSManagedObject category.
//   Author Name:  David F. Negrete
// *********************************************************************************************************************


#import "NSManagedObject+DNDynamic.h"


@implementation NSManagedObject (DNDynamicSetup)


#pragma mark - Constants
const struct NSManagedObjectDynamicMethod {
  __unsafe_unretained NSString *entityInsert;
} NSManagedObjectDynamicMethod;

const struct NSManagedObjectDynamicMethod NSManagedObjectDynamicMethod = {
  .entityInsert = @"insertInManagedObjectContext:with",
};


#pragma mark - Dynamic Invocations
// *********************************************************************************************************************
// + forwardInvocation:
// *********************************************************************************************************************
+ (void) forwardInvocation:(NSInvocation*)anInvocation
{
  SEL aSEL = [anInvocation selector];
  NSString *selectorName = NSStringFromSelector(aSEL);
  
  if( [selectorName hasPrefix:NSManagedObjectDynamicMethod.entityInsert] ) {
    NSArray *selectorKeys = [self objectKeysFromSelectorName:selectorName];
    NSDictionary *objectValues = [self objectValuesFromInvocation:anInvocation keys:selectorKeys];
    
    // Update & Invoke Invocation
    [anInvocation setSelector:@selector(insertInManagedObjectContext:values:)];
    [anInvocation setArgument:&objectValues atIndex:3];
    [anInvocation invoke];
  }
  else {
    [super forwardInvocation:anInvocation];
  }
}

// *********************************************************************************************************************
// + methodSignatureForSelector:
// *********************************************************************************************************************
+ (NSMethodSignature*) methodSignatureForSelector:(SEL)aSelector
{
  NSString *selectorName = NSStringFromSelector(aSelector);
  
  if( [selectorName hasPrefix:NSManagedObjectDynamicMethod.entityInsert] ) {
    NSString *signatureTypes = @"@@:";
    NSUInteger countOfParams = [[selectorName componentsSeparatedByString:@":"] count] - 1;
    
    for( int i = 0; i < countOfParams; i++ ) {
      signatureTypes = [signatureTypes stringByAppendingString:@"@"];
    }
    
    NSMethodSignature *signature = [NSMethodSignature signatureWithObjCTypes:[signatureTypes UTF8String]];
    
    return signature;
  }
  
  return [super methodSignatureForSelector:aSelector];
}


#pragma mark - Helper Methods
// *********************************************************************************************************************
// + objectKeysFromSelectorName:
// *********************************************************************************************************************
+ (NSArray*) objectKeysFromSelectorName:(NSString*)selectorName
{
  NSMutableArray *selectorComponents = [NSMutableArray arrayWithArray:[selectorName componentsSeparatedByString:@":"]];
  NSArray *dynamicComponents = [NSManagedObjectDynamicMethod.entityInsert componentsSeparatedByString:@":"];
  
  [selectorComponents removeObjectAtIndex:0];
  
  selectorComponents[0] = [[selectorComponents[0] stringByRemovingOccurrencesOfStrings:dynamicComponents]
                           stringWithLowercaseFirstLetter];
  
  [selectorComponents removeLastObject];
  
  return selectorComponents;
}

// *********************************************************************************************************************
// + objectValuesFromInvocation: keys:
// *********************************************************************************************************************
+ (NSDictionary*) objectValuesFromInvocation:(NSInvocation*)anInvocation keys:(NSArray*)dictKeys
{
  NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:dictKeys.count];
  
  NSUInteger countOfArgs = [[anInvocation methodSignature] numberOfArguments];
  
  for( int i = 3, j = 0; i < countOfArgs; ++i, ++j ) {
    id objectValue;
    [anInvocation getArgument:&objectValue atIndex:i];
    
    NSString *objectKey = dictKeys[j];
    
    dict[objectKey] = objectValue;
  }
  
  return dict;
}


@end
