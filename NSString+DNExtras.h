// *********************************************************************************************************************
//   Module Name:  NSString+DNExtras.h
//   Description:  Include file.
//   Author Name:  David F. Negrete
// *********************************************************************************************************************


/// NSString category implements convenience methods.
@interface NSString(DNExtras)


/** Remove a substring from another string.
 * @param substring A string object.
 * @return A new string object.
 */
- (NSString*) stringByRemovingOccurrencesOfString:(NSString*)substring;

/** Remove an arbitrary number of strings from another string.
 * @param stringArray An array of strings.
 * @return A new string object.
 */
- (NSString*) stringByRemovingOccurrencesOfStrings:(NSArray*)stringArray;

/** Capitalize only the first letter of a string.
 * @return A new string object.
 */
- (NSString*) stringByCapitalizingFirstLetter;

/** Lowercase only the first letter of a string.
 * @return A new string object.
 */
- (NSString*) stringWithLowercaseFirstLetter;

/** Return a substring between two other strings.
 * @param firstString The string that delimits the beginning of the substring.
 * @param secondString The string that delimits the end of the substring.
 * @return A new string object containing the substring.
 */
- (NSString*) substringBetweenString:(NSString*)firstString andString:(NSString*)secondString;


@end

