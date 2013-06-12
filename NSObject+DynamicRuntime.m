// *********************************************************************************************************************
//   Module Name:  NSObject+DynamicRuntime.m
//   Description:  Dynamically add methods to NSObject instances.
//   Author Name:  David F. Negrete
// *********************************************************************************************************************


#import "NSObject+DynamicRuntime.h" 

#pragma mark Imports
#import <objc/runtime.h>


#pragma mark -
@implementation NSObject (DynamicRuntime)


#pragma mark - Interface (Add)
// *********************************************************************************************************************
// + synthesizeSELNamed: withSELNamed:
// *********************************************************************************************************************
+ (BOOL) synthesizeSELNamed:(NSString*)name1 withSELNamed:(NSString*)name2
{
  SEL selector1 = NSSelectorFromString(name1);
  SEL selector2 = NSSelectorFromString(name2);

  return [self synthesizeSEL:selector1 withSEL:selector2];
}

// *********************************************************************************************************************
// + synthesizeSEL: withSEL:
// *********************************************************************************************************************
+ (BOOL) synthesizeSEL:(SEL)selector1 withSEL:(SEL)selector2
{
  return [self synthesizeSEL:selector1 withSEL:selector2 ofClass:self];
}

// *********************************************************************************************************************
// + addSEL: ofClass:
// *********************************************************************************************************************
+ (BOOL) addSEL:(SEL)selector ofClass:(Class)otherClass
{
  return [self synthesizeSEL:selector withSEL:selector ofClass:otherClass];
}

// *********************************************************************************************************************
// + synthesizeSEL: withSEL: ofClass:
// *********************************************************************************************************************
+ (BOOL) synthesizeSEL:(SEL)selector1 withSEL:(SEL)selector2 ofClass:(Class)sourceClass
{
  Method concreteMethod = class_getInstanceMethod(sourceClass, selector2);

  return [self synthesizeSEL:selector1 withMethod:concreteMethod];
}

// *********************************************************************************************************************
// + includeMethodsOfClass:
// *********************************************************************************************************************
+ (BOOL) includeMethodsOfClass:(Class)sourceClass
{
  BOOL result = YES;
  
  unsigned int numberOfMethods;
  
  Method * methodArray = class_copyMethodList(sourceClass, &numberOfMethods);
  
  for( int k = 0; k < numberOfMethods; k++) {
    Method aMethod = methodArray[k];
    result = [self synthesizeSEL:method_getName(aMethod) withMethod:aMethod] && result;
  }
  
  return result;
}

// *********************************************************************************************************************
// + extendWithMethodsOfClass:
// *********************************************************************************************************************
+ (BOOL) extendWithMethodsOfClass:(Class)otherClass;
{
  return [class_getSuperclass(self) includeMethodsOfClass:otherClass];
}


#pragma mark - Interface (Exchange)
// *********************************************************************************************************************
// + exchangeSELNamed: withSELNamed:
// *********************************************************************************************************************
+ (void) exchangeSELNamed:(NSString*)name1 withSELNamed:(NSString*)name2
{
  SEL selector1 = NSSelectorFromString(name1);
  SEL selector2 = NSSelectorFromString(name2);

  [self exchangeSEL:selector1 withSEL:selector2];
}

// *********************************************************************************************************************
// + exchangeSEL: withSEL:
// *********************************************************************************************************************
+ (void) exchangeSEL:(SEL)selector1 withSEL:(SEL)selector2
{
  Method method1 = class_getInstanceMethod(self, selector1);
  Method method2 = class_getInstanceMethod(self, selector2);

  method_exchangeImplementations(method1, method2);
}


#pragma mark - Convenience
// *********************************************************************************************************************
// - synthesizeSELNamed: withSELNamed:
// *********************************************************************************************************************
- (BOOL) synthesizeSELNamed:(NSString*)name1 withSELNamed:(NSString*)name2
{
  return [[self class] synthesizeSELNamed:name1 withSELNamed:name2];
}

// *********************************************************************************************************************
// - synthesizeSEL: withSEL:
// *********************************************************************************************************************
- (BOOL) synthesizeSEL:(SEL)selector1 withSEL:(SEL)selector2
{
  return [[self class] synthesizeSEL:selector1 withSEL:selector2];
}

// *********************************************************************************************************************
// - addSEL: ofClass:
// *********************************************************************************************************************
- (BOOL) addSEL:(SEL)selector ofClass:(Class)otherClass
{
  return [[self class] addSEL:selector ofClass:otherClass];
}

// *********************************************************************************************************************
// - exchangeSEL: withSEL:
// *********************************************************************************************************************
- (void) exchangeSEL:(SEL)selector1 withSEL:(SEL)selector2
{
  [[self class] exchangeSEL:selector1 withSEL:selector2];
}


#pragma mark - Private
// *********************************************************************************************************************
// + synthesizeSEL: withMethod:
// *********************************************************************************************************************
+ (BOOL) synthesizeSEL:(SEL)selector withMethod:(Method)concreteMethod;
{
  IMP concreteImplementation = method_getImplementation(concreteMethod);
  const char *concreteImplementationTypes = method_getTypeEncoding(concreteMethod);
  
  BOOL result = class_addMethod(self, selector, concreteImplementation, concreteImplementationTypes);
  
  return result;
}


@end
