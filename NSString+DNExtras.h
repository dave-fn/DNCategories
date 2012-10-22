// *********************************************************************************************************************
//   Module Name:  NSString+DNExtras.h
//   Description:  Include file.
//   Author Name:  David F. Negrete
// *********************************************************************************************************************
//   Date         Description
//   ----------   ----------------------------------------------------------------------------------------------------
//   2012.08.14   Initial Creation.
// *********************************************************************************************************************


/**
 * NSString category.
 */
@interface NSString(DNExtras)


/**
 * Remove an arbitrary number of strings from another string.
 * @param stringArray An array of strings.
 * @return A new string object.
 */
- (NSString*) stringByRemovingOccurrencesOfStrings:(NSArray*)stringArray;

/**
 * Capitalize only the first letter of a string.
 * @return A new string object.
 */
- (NSString*) stringByCapitalizingFirstLetter;

/**
 * Lowercase only the first letter of a string.
 * @return A new string object.
 */
- (NSString*) stringWithLowercaseFirstLetter;


@end

