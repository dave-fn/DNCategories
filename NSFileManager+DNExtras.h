// *********************************************************************************************************************
//   Module Name:  NSFileManager+DNExtras.h
//   Description:  Include file.
//   Author Name:  David F. Negrete
// *********************************************************************************************************************


/** NSFileManager category implements a convenience method to get the application support directory.
 *
 * The directory path is determined from the calling application by obtaining its name from the main bundle.
 * It will create the directory if it doesn't exist.
 */
@interface NSFileManager (DNExtras)


/** Get the application support directory path and create a folder if it doesn't exist.
 * @return A String object with the path.
 * @see applicationSupportDirectoryURL
 */
- (NSString*) applicationSupportDirectory;

/** Get the application support directory URL and create a folder if it doesn't exist.
 * @return A URL object with the path.
 * @see applicationSupportDirectory
 */
- (NSURL*) applicationSupportDirectoryURL;

/** Get the support directory of an application from its name.  The support directory is created if it doesn't exist.
 * @param appName The name of the folder in the application support folder.
 * @param error An error object in case the directory could not be created.
 * @return The URL to the application support directory.
 */
- (NSURL*) applicationSupportURLOfApplication:(NSString*)appName error:(NSError**)error;

//TODO: Add eachFile -- and process with block
//TODO: Add eachDirectory -- and process with block

@end
