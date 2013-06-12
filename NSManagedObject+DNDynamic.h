// *********************************************************************************************************************
//   Module Name:  NSManagedObject+DNDynamic.h
//   Description:  Include file.
//   Author Name:  David F. Negrete
// *********************************************************************************************************************


/** NSManagedObject category for setting up methods implemented dynamically.
 *
 * Dynamic methods can be implemented with the following pattern:
 *
 * `- insertInManagedObjectContext: with<Key>:(id)value <key>:(id)value <key>:(id)value ...`
 *
 * @note Dynamic Methods have to be defined as a category of the actual managed object class.
 */
@interface NSManagedObject (DNDynamicSetup)
@end
