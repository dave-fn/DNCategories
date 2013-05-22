// *********************************************************************************************************************
//   Module Name:  NSMutableArray+DNExtras.h
//   Description:  Include file.
//   Author Name:  David F. Negrete
// *********************************************************************************************************************
//   Date         Description
//   ----------   ----------------------------------------------------------------------------------------------------
//   2012.09.13   Initial Creation.
// *********************************************************************************************************************


/** @category NSMutableArray(DNExtras)
 * NSMutableArray category implements one method to switch objects within the collection.
 */
@interface NSMutableArray(DNExtras)


/** Moves an object to a new position within the array.
 * @param fromIndex The index position of the object.
 * @param toIndex The index position to which the object will be moved.
 */
- (void) moveObjectAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;


@end

