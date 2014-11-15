//
//  TSPathHelper.m
//  HexMeister
//
//  Created by Tristan Seifert on 11/14/14.
//  Copyright (c) 2014 Tristan Seifert. All rights reserved.
//

#import "TSPathHelper.h"

static TSPathHelper *sharedInstance = nil;

@implementation TSPathHelper

/**
 * Creates the shared path helper, if required.
 *
 * @returns Path helper object, shared.
 */
+ (instancetype) sharedInstance {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[TSPathHelper alloc] init];
	});
	
	return sharedInstance;
}

/**
 * Gets the application support directory.
 */
- (NSArray *) applicationSupport {
	NSString *exec = [NSBundle mainBundle].infoDictionary[@"CFBundleExecutable"];
	NSArray *derp = [self pathsInApplicationSupport:exec];
	
	// does user's path exist
	if(![[NSFileManager defaultManager] fileExistsAtPath:derp[2]]) {
		NSError *err = nil;
//		DDLogVerbose(@"Creating %@", derp[2]);
		
		[[NSFileManager defaultManager] createDirectoryAtPath:derp[2]
								  withIntermediateDirectories:YES
												   attributes:nil
														error:&err];
		DDAssert(!err, @"Creating application support dir failed");
	}
	
	return derp;
}

#pragma mark - Folder stuff
/**
 * Finds the plugin path
 */
- (NSArray *) pluginPaths {
	NSArray *path = [self applicationSupport];
	NSMutableArray *paths = [NSMutableArray new];
	
	// go through the paths
	for (NSString *newPath in path) {
		if([[NSFileManager defaultManager] fileExistsAtPath:newPath]) {
			[paths addObject:newPath];
		}
	}
	
	// add plugin path
	[paths addObject:[NSBundle mainBundle].builtInPlugInsPath];
	
	return paths;
}


/**
 * Returns an array of three paths of "inSubPath" in the system, local, and user
 * library directories.
 *
 * @param inSubPath Subpath in Library directories.
 * @returns An array of the System, Local, and User library paths.
 */
-  (NSArray *) pathsInApplicationSupport:(NSString *) inSubPath {
	NSMutableArray *arr = [NSMutableArray new];
	
	// system library (/System/Library)
	NSArray *domains = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSSystemDomainMask, YES);
	NSString *baseDir= [domains objectAtIndex:0];
	NSString *result = [baseDir stringByAppendingPathComponent:inSubPath];
	[arr addObject:result];
	
	// local library (/Library)
	domains = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSLocalDomainMask, YES);
	baseDir= [domains objectAtIndex:0];
	result = [baseDir stringByAppendingPathComponent:inSubPath];
	[arr addObject:result];
	
	// user's library (~/Library)
	domains = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
	baseDir= [domains objectAtIndex:0];
	result = [baseDir stringByAppendingPathComponent:inSubPath];
	[arr addObject:result];
	
	return arr;
}

@end
