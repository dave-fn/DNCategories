// *********************************************************************************************************************
//   Module Name:  NSDatePicker+DNExtras.m
//   Description:  NSDatePicker category.
//   Author Name:  David F. Negrete
// *********************************************************************************************************************


#import "NSDatePicker+DNExtras.h"


@implementation NSDatePicker (DNExtras)


// *********************************************************************************************************************
// - dateComponentsValue
// *********************************************************************************************************************
- (NSDateComponents*) dateComponentsValue
{
  unsigned unitFlags = NSDayCalendarUnit;
  NSDatePickerElementFlags pickerElements = [self datePickerElements];
  
  if( pickerElements == NSYearMonthDayDatePickerElementFlag ) {
    unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
  }
  else if( pickerElements == NSYearMonthDatePickerElementFlag ) {
    unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit;
  }
  else if( pickerElements == NSHourMinuteDatePickerElementFlag ) {
    unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit;
  }
  else if( pickerElements == NSHourMinuteSecondDatePickerElementFlag ) {
    unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
  }
  
  NSDateComponents *dateComponents = [[self calendar] components:unitFlags fromDate:[self dateValue]];
  
  return dateComponents;
}


@end
