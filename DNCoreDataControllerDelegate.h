// *********************************************************************************************************************
//   Module Name:  DNCoreDataControllerDelegate.h
//   Description:  Protocol definition.
//   Author Name:  David F. Negrete
// *********************************************************************************************************************


@class DNCoreDataController;


/// Methods required by a Core Data Controller to setup the stack.
@protocol DNCoreDataControllerDelegate <NSObject>


@required
/** Specify the URL to the Data Model for the given controller object.
 * @param coreData The Core Data Controller object.
 * @return An URL object.
 */
- (NSURL*) coreDataModelURL:(DNCoreDataController*)coreData;

/** Specify the Core Data Store type for the given controller object.
 * @param coreData The Core Data Controller object.
 * @return A String object.
 */
- (NSString*) coreDataStoreType:(DNCoreDataController*)coreData;


@optional
/** Specify the Core Data Store name of persistent file.
 * @param coreData The Core Data Controller object.
 * @return A String object.
 */
- (NSString*) coreDataStoreName:(DNCoreDataController*)coreData;

/** Specify the URL to the directory in which the store will be persisted.
 * @param coreData The Core Data Controller object.
 * @return An URL object.
 */
- (NSURL*) coreDataStoreDirectory:(DNCoreDataController*)coreData;

/** Specify the URL to the Core Data Store for the given controller object.
 * @param coreData The Core Data Controller object.
 * @return An URL object.
 */
- (NSString*) coreDataStoreExtension:(DNCoreDataController*)coreData;


@end
