// *********************************************************************************************************************
//   Module Name:  NSObject+NSCoding.h
//   Description:  Include file.
//   Author Name:  Outis at http://stackoverflow.com/questions/4317164/save-own-class-with-nscoder / David F. Negrete
// *********************************************************************************************************************
//   Date         Description
//   ----------   ----------------------------------------------------------------------------------------------------
//   2012.08.14   Initial Creation.
// *********************************************************************************************************************


/**
 * @category NSObject(NSCoding)
 * NSObject Category implementing the NSCoding Protocol.
 * This allows to call [super initWithCoder:] and not require to verify that the superclass
 * implements it or not.
 */
@interface NSObject(NSCoding)


/**
 * Extension that just calls init.
 * @param decoder The decoder object.
 * @return The decoded object.
 */
- (id) initWithCoder:(NSCoder*)decoder;

/**
 * Extension that does nothing.
 * @param encoder The encoder object.
 */
- (void) encodeWithCoder:(NSCoder*)encoder;

/**
 * Convenience method.
 * Specifies no options and null context.
 * @param keyPath Key Path to observe.
 * @param anObject The object to observe.
 */
- (void) observeKeyPath:(NSString*)keyPath ofObject:(id)anObject;

/**
 * Convenience method.
 * Specifies null context.
 * @param keyPath Key Path to observe.
 * @param anObject The object to observe.
 * @param options The Key Value Observing options.
 */
- (void) observeKeyPath:(NSString*)keyPath ofObject:(id)anObject options:(NSKeyValueObservingOptions)options;

/**
 * Convenience method.
 * @param keyPath Key Path to stop observing.
 * @param anObject The object to stop observing.
 */
- (void) stopObservingKeyPath:(NSString*)keyPath ofObject:(id)anObject;


@end

