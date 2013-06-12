// *********************************************************************************************************************
//   Module Name:  NSArray+DNExtras.h
//   Description:  Include file.
//   Author Name:  David F. Negrete
// *********************************************************************************************************************


/// NSArray category implements Ruby-like block extensions.
@interface NSArray (DNExtras)


/** Executes a block with each element in array.
 * @param eachBlock The block to execute.
 */
- (void) each:(void(^)(id arrayObject))eachBlock;

/** Creates a new array by executing a block with each element in array.
 * @param mapBlock The block to execute.
 * @return The new array.
 */
- (NSArray*) map:(id(^)(id arrayObject))mapBlock;

/** Creates a new array by including only objects which pass a test given by a block.
 * @param selectBlock The block to execute.
 * @return The new array.
 */
- (NSArray*) arrayBySelecting:(BOOL(^)(id arrayObject))selectBlock;

/** Creates a new array by excluding only objects which pass a test given by a block.
 * @param rejectBlock The block to execute.
 * @return The new array.
 */
- (NSArray*) arrayByRejecting:(BOOL(^)(id arrayObject))rejectBlock;


@end
