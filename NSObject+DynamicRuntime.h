// *********************************************************************************************************************
//   Module Name:  NSObject+DynamicRuntime.h
//   Description:  Include file.
//   Author Name:  David F. Negrete
// *********************************************************************************************************************


/** NSObject category implementing ObjC-like wrapper calls to the runtime.
 *
 * This category allows objects to generate methods at runtime.
 */
@interface NSObject (DynamicRuntime)


#pragma mark - Interface
/// @name Add Single Method
/// -----------------------

/** Synthesize a selector from another selector already implemented.
 * This routine will determine the selectors from two strings.
 * @param name1 The name of the selector to dynamically implement.
 * @param name2 The name of the selector already existing.
 * @return A boolean value indicating if the operation was completed successfully.
 */
+ (BOOL) synthesizeSELNamed:(NSString*)name1 withSELNamed:(NSString*)name2;

/** Synthesize a selector from another selector already implemented.
 * @param selector1 The selector to dynamically implement.
 * @param selector2 The selector already existing.
 * @return A boolean value indicating if the operation was completed successfully.
 */
+ (BOOL) synthesizeSEL:(SEL)selector1 withSEL:(SEL)selector2;

/** Add a selector to the receiving class from another class.
 * @param selector The selector to add.
 * @param otherClass The Class implementing the functionality.
 * @return A boolean value indicating if the operation was completed successfully.
 */
+ (BOOL) addSEL:(SEL)selector ofClass:(Class)otherClass;

/** Add a selector to the receiving class from another class, but implement it with a different selector.
 * @param selector1 The selector to dynamically implement.
 * @param selector2 The selector already existing.
 * @param otherClass The class implementing the functionality.
 * @return A boolean value indicating if the operation was completed successfully.
 */
+ (BOOL) synthesizeSEL:(SEL)selector1 withSEL:(SEL)selector2 ofClass:(Class)otherClass;


/// @name Add Multiple Methods
/// --------------------------

/** Iterate through each method of a class and add it to the receiving class as an instance method.
 * Existing methods in the current class are not overwritten or overridden.
 * @param otherClass The class implementing the functionality.
 * @return A boolean value indicating if the operation was completed successfully.
 */
+ (BOOL) includeMethodsOfClass:(Class)otherClass;

/** Iterate through each method of a class and add it to the receiving class as a class method.
 * Existing methods in the current class are not overwritten or overridden.
 * @param otherClass The class implementing the functionality.
 * @return A boolean value indicating if the operation was completed successfully.
 */
+ (BOOL) extendWithMethodsOfClass:(Class)otherClass;


/// @name Exchange Methods
/// ----------------------

/** Exchanges the implementation of two selectors.
 * @param name1 The name of a selector.
 * @param name2 The name of a selector.
 */
+ (void) exchangeSELNamed:(NSString*)name1 withSELNamed:(NSString*)name2;

/** Exchanges the implementation of two selectors.
 * @param selector1 A selector.
 * @param selector2 A selector.
 */
+ (void) exchangeSEL:(SEL)selector1 withSEL:(SEL)selector2;


#pragma mark - Convenience
/// @name Convenience
/// -----------------

/** Synthesize a selector from another selector already implemented.
 * This routine will determine the selectors from two strings.
 * This method calls the class implementation, therefore, every instance of the given class will also be able to call
 * the methods implemented dynamically.
 * @param name1 The name of the selector to dynamically implement.
 * @param name2 The name of the selector already existing.
 * @return A boolean value indicating if the operation was completed successfully.
 * @see +synthesizeSELNamed:withSELNamed:
 */
- (BOOL) synthesizeSELNamed:(NSString*)name1 withSELNamed:(NSString*)name2;

/** Synthesize a selector from another selector already implemented.
 * This method calls the class implementation, therefore, every instance of the given class will also be able to call
 * the methods implemented dynamically.
 * @param selector1 The selector to dynamically implement.
 * @param selector2 The selector already existing.
 * @return A boolean value indicating if the operation was completed successfully.
 * @see synthesizeSEL:withSEL:
 */
- (BOOL) synthesizeSEL:(SEL)selector1 withSEL:(SEL)selector2;

/** Add a selector to the receiving class from another class.
 * This method calls the class implementation, therefore, every instance of the given class will also be able to call
 * the methods implemented dynamically.
 * @param selector The selector to add.
 * @param otherClass The Class implementing the functionality.
 * @return A boolean value indicating if the operation was completed successfully.
 * @see addSEL:ofClass:
 */
- (BOOL) addSEL:(SEL)selector ofClass:(Class)otherClass;

/** Exchange the implementation of two selectors.
 * This method calls the class implementation, therefore, every instance of the given class will also have the
 * selectors exchanged.
 * @param selector1 A selector.
 * @param selector2 A selector.
 * @see +exchangeSEL:withSEL:
 */
- (void) exchangeSEL:(SEL)selector1 withSEL:(SEL)selector2;


@end
