// *********************************************************************************************************************
//   Module Name:  NSManagedObjectContext+DNExtras.h
//   Description:  Include file.
//   Author Name:  David F. Negrete
// *********************************************************************************************************************


/// NSManagedObjectContext category implementing convenience fetch methods.
@interface NSManagedObjectContext (DNExtras)


/** Inserts a new managed object into the context.
 * @param entityName The name of the Core Data entity.
 * @return The NSManagedObject object created.
 */
- (id) insertNewObjectForEntityForName:(NSString*)entityName;

/** Determine the number of objects for a given entity and criteria.
 * @param entityName The name of the Core Data entity.
 * @param pred The predicate used to match the objects.
 * @return The number of matching objects.
 */
- (NSUInteger) countObjectsForEntityForName:(NSString*)entityName predicate:(NSPredicate*)pred;

/** Retrieve Core Data objects of a given entity.
 * @param entityName The name of the Core Data entity.
 * @return A set containing the retrieved objects.
 */
- (NSSet*) fetchObjectsForEntityForName:(NSString*)entityName;

/** Retrieve Core Data objects of a given entity meeting specified criteria.
 * @param entityName The name of the Core Data entity.
 * @param pred The predicate used to filter the objects.
 * @return A set containing the retrieved objects.
 */
- (NSSet*) fetchObjectsForEntityForName:(NSString*)entityName predicate:(NSPredicate*)pred;

/** Retrieve Core Data objects of a given entity meeting specified criteria and sort according to specified sort order.
 * @param entityName The name of the Core Data entity.
 * @param sortKey The key to be used to sort.
 * @param asc A boolean indicating if the objects should be sorted in ascending or descending order.
 * @param pred The predicate used to filter the objects.
 * @return An array containaing the ordered retrieved objects.
 */
- (NSArray*) fetchObjectsForEntityForName:(NSString*)entityName
                                   sortBy:(NSString*)sortKey
                                ascending:(BOOL)asc
                                predicate:(NSPredicate*)pred;

/** Retrieve Core Data objects of a given entity meeting specified criteria and sort according to specified sort order.
 * @param entityName The name of the Core Data entity.
 * @param sortKey The key to be used to sort.
 * @param asc A boolean indicating if the objects should be sorted in ascending or descending order.
 * @param pred The predicate used to filter the objects.
 * @param limit The maximum number of objects that should be returned.  0 specifies no limit.
 * @return An array containaing the ordered retrieved objects.
 */
- (NSArray*) fetchObjectsForEntityForName:(NSString*)entityName
                                   sortBy:(NSString*)sortKey
                                ascending:(BOOL)asc
                                predicate:(NSPredicate*)pred
                                    limit:(NSUInteger)limit;


@end
