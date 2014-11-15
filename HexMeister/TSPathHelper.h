//
//  TSPathHelper.h
//  HexMeister
//
//  Created by Tristan Seifert on 11/14/14.
//  Copyright (c) 2014 Tristan Seifert. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSPathHelper : NSObject

/**
 * Creates the shared path helper, if required.
 *
 * @returns Path helper object, shared.
 */
+ (instancetype) sharedInstance;

/**
 * Gets the application support directory.
 */
- (NSArray *) applicationSupport;

/**
 * Finds the plugin path
 */
- (NSArray *) pluginPaths;

/**
 * Returns an array of three paths of "inSubPath" in the system, local, and user
 * library directories.
 *
 * @param inSubPath Subpath in Library directories.
 * @returns An array of the System, Local, and User library paths.
 */
-  (NSArray *) pathsInApplicationSupport:(NSString *) inSubPath;

@end
