// *********************************************************************************************************************
//   Module Name:  NSDictionary+DNExtras.h
//   Description:  Include file.
//   Author Name:  David F. Negrete
// *********************************************************************************************************************


/// NSDictionary category implements Ruby-like block extensions.
@interface NSDictionary (DNExtras)


/** Executes a block with each key-value pair in dictionary.
 * @param eachBlock The block to execute.
 */
- (void) each:(void(^)(id key, id value))eachBlock;


@end
