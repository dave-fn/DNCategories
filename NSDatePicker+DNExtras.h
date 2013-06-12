// *********************************************************************************************************************
//   Module Name:  NSDatePicker+DNExtras.h
//   Description:  Include file.
//   Author Name:  David F. Negrete
// *********************************************************************************************************************


/// NSDatePicker category implements a convenience method to retrieve the date components directly.
@interface NSDatePicker (DNExtras)


/** Get the components date from the picker directly from the current calendar.
 * @return The Date Components object.
 */
- (NSDateComponents*) dateComponentsValue;


@end
