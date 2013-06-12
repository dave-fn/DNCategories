// *********************************************************************************************************************
//   Module Name:  NSManagedObjectContext+DNDynamic.h
//   Description:  Include file.
//   Author Name:  David F. Negrete
// *********************************************************************************************************************


#pragma mark Forward Declarations
// Add Classes here


/** NSManagedObjectContext category defines convenience fetch methods implemented dynamically.
 *
 * The purpose of these methods is to provide app-specific methods.  This category serves to declare interface methods
 * to the dynamic methods, such as those required to setup.
 */
@interface NSManagedObjectContext (DNDynamicSetup)
@end


/** Available dynamic methods.  These methods are not implemented but rather resolved at runtime.
 *
 * Dynamic method can be implemented with the following patterns:
 *
 *   `- fetchEvery<Entity>`
 *
 *   `- fetchEvery<Entity>With<Key>:(id)value`
 *
 *   `- fetchEvery<Entity>SortedBy<Key>:(BOOL)ascending`
 *
 *   `- fetchThe<Entity>With:(id)value`
 *
 *   `- countEvery<Entity>`
 *
 *   `- countEvery<Entity>With<Key>:(id)value`
 */
@interface NSManagedObjectContext (DNDynamic)

// Add Dynamic Methods here

@end
