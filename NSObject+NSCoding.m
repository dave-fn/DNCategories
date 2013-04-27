// *********************************************************************************************************************
//   Module Name:  NSObject+NSCoding.m
//   Description:  NSObject Category.
//   Author Name:  outis at http://stackoverflow.com/questions/4317164/save-own-class-with-nscoder / David F. Negrete
// *********************************************************************************************************************
//   Date         Description
//   ----------   ----------------------------------------------------------------------------------------------------
//   2012.08.14   Initial Creation.
// *********************************************************************************************************************


#import "NSObject+NSCoding.h"


@implementation NSObject(NSCoding)


// *********************************************************************************************************************
// - initWithCoder:
// *********************************************************************************************************************
- (id) initWithCoder:(NSCoder*)decoder
{
  return [self init];
}

// *********************************************************************************************************************
// - encodeWithCoder:
// *********************************************************************************************************************
- (void) encodeWithCoder:(NSCoder*)encoder {}

// *********************************************************************************************************************
// - observeKeyPath: ofObject:
// *********************************************************************************************************************
- (void) observeKeyPath:(NSString*)keyPath ofObject:(id)anObject
{
  //[anObject addObserver:self forKeyPath:keyPath options:0 context:NULL];
  [anObject addObserver:self forKeyPath:keyPath
                options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:NULL];
}

// *********************************************************************************************************************
// - observeKeyPath: ofObject: options:
// *********************************************************************************************************************
- (void) observeKeyPath:(NSString*)keyPath ofObject:(id)anObject options:(NSKeyValueObservingOptions)options
{
  [anObject addObserver:self forKeyPath:keyPath options:options context:NULL];
}

// *********************************************************************************************************************
// - stopObservingKeyPath: ofObject:
// *********************************************************************************************************************
- (void) stopObservingKeyPath:(NSString*)keyPath ofObject:(id)anObject
{
  [anObject removeObserver:self forKeyPath:keyPath];
}


@end

