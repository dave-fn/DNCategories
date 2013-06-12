// *********************************************************************************************************************
//   Module Name:  NSMutableArray+DNExtras.h
//   Description:  Include file.
//   Author Name:  David F. Negrete
// *********************************************************************************************************************


/** NSMutableArray category implements one method to switch objects within the collection and several Ruby-like block
 * extensions.
 */
@interface NSMutableArray(DNExtras)


/** Moves an object to a new position within the array.
 * @param fromIndex The index position of the object.
 * @param toIndex The index position to which the object will be moved.
 */
- (void) moveObjectAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

/** Updates an array by selecting only objects passing a test given by a block; the rest of the elements are discarded.
 * @param selectBlock The block used to determine if the iterated object should be selected.
 */
- (void) select:(BOOL(^)(id arrayObject))selectBlock;

/** Updates an array by reject objects passing a test given by a block; the rest of the elements are kept.
 * @param rejectBlock The block used to determine if the iterated object should be rejected.
 */
- (void) reject:(BOOL(^)(id arrayObject))rejectBlock;


@end

