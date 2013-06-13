// *********************************************************************************************************************
//   Module Name:  DNCoreDataControllerDelegate.h
//   Description:  Protocol definition.
//   Author Name:  David F. Negrete
// *********************************************************************************************************************


/// Methods required by a NSManagedObject subclass to implement dynamic methods.
@protocol NSManagedObjectDynamic <NSObject>


@required
/** Concrete method used to initialize a managed object from a dynamic method.
 * @param moc The Managed Object Context in which to insert the object.
 * @param valuesDict The Dictionary with the initializing values.
 * @return The managed object.
 */
+ (id) insertInManagedObjectContext:(NSManagedObjectContext*)moc values:(NSDictionary*)valuesDict;


@optional


@end
