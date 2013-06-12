// *********************************************************************************************************************
//   Module Name:  NSManagedObjectContext+DNExtras.m
//   Description:  NSManagedObjectContext category.
//   Author Name:  David F. Negrete
// *********************************************************************************************************************


#import "NSManagedObjectContext+DNExtras.h"


@implementation NSManagedObjectContext (DNExtras)


// *********************************************************************************************************************
// - insertNewObjectForEntityForName:
// *********************************************************************************************************************
- (id) insertNewObjectForEntityForName:(NSString*)entityName
{
  return [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:self];
}

// *********************************************************************************************************************
// - countObjectsForEntityForName: predicate:
// *********************************************************************************************************************
- (NSUInteger) countObjectsForEntityForName:(NSString*)entityName predicate:(NSPredicate*)pred
{
  NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
  [request setPredicate:pred];

  NSError *fetchError = nil;
  NSUInteger result = [self countForFetchRequest:request error:&fetchError];

  if( result == NSNotFound ) {
     //TODO: Core Data Error // Present message, what needs to be done here?
    DNLog(@"ERROR: Did not perform count fetch successfully");
  }

  return result;
}

// *********************************************************************************************************************
// - fetchObjectsForEntityForName:
// *********************************************************************************************************************
- (NSSet*) fetchObjectsForEntityForName:(NSString*)entityName
{
  return [self fetchObjectsForEntityForName:entityName predicate:nil];
}

// *********************************************************************************************************************
// - fetchObjectsForEntityForName: predicate:
// *********************************************************************************************************************
- (NSSet*) fetchObjectsForEntityForName:(NSString*)entityName predicate:(NSPredicate*)pred
{
  NSArray *fetchedObjects = [self fetchObjectsForEntityForName:entityName sortBy:nil ascending:NO predicate:pred];
  
  return [NSSet setWithArray:fetchedObjects];
}

// *********************************************************************************************************************
// - fetchObjectsForEntityForName: sortBy: ascending: predicate:
// *********************************************************************************************************************
- (NSArray*) fetchObjectsForEntityForName:(NSString*)entityName
                                   sortBy:(NSString*)sortKey
                                ascending:(BOOL)asc
                                predicate:(NSPredicate*)pred
{
  return [self fetchObjectsForEntityForName:entityName sortBy:sortKey ascending:asc predicate:pred limit:0];
}

// *********************************************************************************************************************
// - fetchObjectsForEntityForName: sortBy: ascending: predicate: limit:
// *********************************************************************************************************************
- (NSArray*) fetchObjectsForEntityForName:(NSString*)entityName
                                   sortBy:(NSString*)sortKey
                                ascending:(BOOL)asc
                                predicate:(NSPredicate*)pred
                                    limit:(NSUInteger)fetchLimit
{
  NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:entityName];
  [req setPredicate:pred];
  [req setFetchLimit:fetchLimit];
  
  if( sortKey ) {
    NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:sortKey ascending:asc]]; 
    [req setSortDescriptors:sortDescriptors];
  }
  
  NSError *fetchError = nil;
  NSArray *results = [self executeFetchRequest:req error:&fetchError];
  
  if( !results ) {
    //TODO: Core Data Error // Present message, what needs to be done here?
    DNLog(@"ERROR: Did not perform fetch successfully");
  }
  
  return results;
}


@end
