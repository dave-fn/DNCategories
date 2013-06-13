// *********************************************************************************************************************
//   Module Name:  DNOrderedManagedObject.h
//   Description:  Include file.
//   Author Name:  David F. Negrete
// *********************************************************************************************************************


#pragma mark Forward Declarations


#pragma mark -
/** An NSManagedObject subclass implementing ordered relationships.
 * A relationship will be considered as ordered if it's implemented as follows:
 *
 *   `relationship:  <key>          to-many`
 *
 *   `attribute:     ordered<Key>   transient`
 *
 * In addition, the entity in the ordered relationship must implement the following:
 *
 *   `attribute:     ordered<Key>Index   integer`
 */
@interface DNOrderedManagedObject : NSManagedObject


#pragma mark - Class Interface
/// @name Derived Keys
/// ------------------

/** Get the name of the ordered relationship for a given key.
 * @param key The name of the relationship.
 * @return A String object.
 */
+ (NSString*) orderingKeyForRelationshipKey:(NSString*)key;

/** Get the name of the indexing attribute.
 * @param key The name of the relationship.
 * @return A String object.
 */
+ (NSString*) orderingIndexForRelationshipKey:(NSString*)key;


#pragma mark - Interface (Accessors)
/// @name Basic Accessors
/// ---------------------

/** Primitive accessor for the ordered relationship.
 * @param key The name of the relationship.
 * @return The objects in an ordered array.
 */
- (NSMutableArray*) primitiveOrderedValueForKey:(NSString*)key;

/** Primitive accessor for the ordered relationship.
 * @param value An array with the value of the ordered relationship.
 * @param key The name of the relationship.
 */
- (void) setPrimitiveOrderedValue:(NSMutableArray*)value forKey:(NSString*)key;

/** Accessor for the ordered relationship.
 * @param key The name of the relationship.
 * @return The objects in an ordered array.
 */
- (NSArray*) orderedValueForKey:(NSString*)key;

/** Accessor for the ordered relationship.
 * @param value An array with the value of the ordered relationship.
 * @param key The name of the relationship.
 */
- (void) setOrderedValue:(NSArray*)value forKey:(NSString*)key;


#pragma mark - Interface (Modifiers)
/// @name To-Many Accessors
/// -----------------------

/** Add an object to the end of the ordered relationship.
 * @param anObject The managed object to add.
 * @param key The name of the relationship.
 * @see insertObject:inOrderedValueAtIndex:forKey:
 */
- (void) addObject:(NSManagedObject*)anObject toOrderedValueForKey:(NSString*)key;

/** Insert an object at a specific position within the ordered relationship.
 * @param anObject The managed object to insert.
 * @param index Position of the object within the ordered relationship.
 * @param key The name of the relationship.
 */
- (void) insertObject:(NSManagedObject*)anObject inOrderedValueAtIndex:(NSUInteger)index forKey:(NSString*)key;

/** Get an object at a given position within the ordered relationship.
 * @param index Position of the object within the ordered relationship.
 * @param key The name of the relationship.
 * @return An object.
 * @bug Method not implemented.
 */
- (NSManagedObject*) objectInOrderedValueAtIndex:(NSUInteger)index forKey:(NSString*)key;

/** Determine the position of an object within the ordered relationship.
 * @param anObject The managed object to find.
 * @param key The name of the relationship.
 * @return The position of the object.
 */
- (NSUInteger) indexOfObject:(NSManagedObject*)anObject inOrderedValueForKey:(NSString*)key;

/** Remove an object from the ordered relationship.
 * @param index Position of the object within the ordered relationship.
 * @param key The name of the relationship.
 */
- (void) removeObjectFromOrderedValueAtIndex:(NSUInteger)index forKey:(NSString*)key;

/** Count of objects in the ordered relationship.
 * @param key The name of the relationship.
 * @return An integer with the count of objects.
 */
- (NSUInteger) countOfOrderedValueForKey:(NSString*)key;

/** Update the position of an object within the ordered relationship.
 * @param index1 The original index.
 * @param index2 The new index.
 * @param key The name of the relationship.
 */
- (void) moveObjectFromOrderedValueAtIndex:(NSUInteger)index1 toIndex:(NSUInteger)index2 forKey:(NSString*)key;


#pragma mark - Convenience
/// @name Convenience
/// -----------------

/** Convenience method.
 * @see orderingKeyForRelationshipKey:
 * @param key The name of the relationship.
 * @return The ordered relationship.
 */
- (NSString*) orderingKeyForRelationshipKey:(NSString*)key;

/** Returns an array with the keys setup as ordered relationships.
 * @return An Array object.
 */
- (NSArray*) orderedKeys;


@end
