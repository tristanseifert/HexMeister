//
//  TSPlugInManager.m
//  HexMeister
//
//	Responsible for finding, loading and generally taking care of plugins. Keeps
//	track of their data formatter hooks, and provides information for managing
//	plugins effectively.
//
//  Created by Tristan Seifert on 11/14/14.
//  Copyright (c) 2014 Tristan Seifert. All rights reserved.
//

#import "TSPathHelper.h"
#import "TSPlugIn.h"

#import "TSDataType.h"

#import "TSPlugInManager.h"

static TSPlugInManager *sharedInstance = nil;

@interface TSPlugInManager ()

- (void) enumeratePlugins;
- (void) enumeratePluginsInDirectory:(NSString *) path;

@end

@implementation TSPlugInManager

- (id) init {
	if(self = [super init]) {
		_plugInBundles = [NSMutableArray new];
		
		[self enumeratePlugins];
	}
	
	return self;
}

/// Returns shared instance
+ (instancetype) sharedInstance {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[TSPlugInManager alloc] init];
	});
	
	return sharedInstance;
}

#pragma mark - Plugin Discovery
/**
 * Enumerates the system, local, and user's Application Support directory for
 * plugins, then enumerartes the the app bundle's PlugIns folder.
 *
 * @note This does not actually load any plugins.
 */
- (void) enumeratePlugins {
	NSArray *paths = [[TSPathHelper sharedInstance] pluginPaths];
	for (NSString *path in paths) {
		[self enumeratePluginsInDirectory:path];
	}
}

/**
 * Enumerates plugins in a specific directory;
 */
- (void) enumeratePluginsInDirectory:(NSString *) path {
	NSError *err = nil;
	NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:&err];
	DDAssert(!err, @"Error enumerating for plugins in %@: %@", path, err);
	
	for (NSString *filename in contents) {
		NSString *fullpath = [path stringByAppendingPathComponent:filename];
		
		// load it as a bundle
		NSBundle *bundle = [NSBundle bundleWithPath:fullpath];
		if(bundle) {
			// preflight the plugin
			if([bundle preflightAndReturnError:&err]) {
				[_plugInBundles addObject:bundle];
			} else {
				DDLogWarn(@"Couldn't preflight %@: %@", filename, err);
			}
		}
	}
}

#pragma mark - Plugin loading
/**
 * Loads the plugins that were discovered previously.
 */
- (void) loadPlugins {	
	NSMutableArray *pluginInstanes = [NSMutableArray new];
	
	for (NSBundle *bundle in _plugInBundles) {
		NSError *err = nil;
		
		if([bundle loadAndReturnError:&err]) {
			// instantiate the principal class
			DDAssert([bundle.principalClass conformsToProtocol:@protocol(TSPlugIn)],
					 @"Plugins must implement TSPlugIn!");
			
			id<TSPlugIn> plugin = [[bundle.principalClass alloc] initWithPluginManager:self
																			withBundle:bundle];
			if(plugin) {
				[pluginInstanes addObject:plugin];
			} else {
				DDLogWarn(@"Plugin %@ (%@) failed to initialise, skipping", bundle,
						  NSStringFromClass(bundle.principalClass));
			}
		} else {
			DDLogWarn(@"Error loading %@: %@", bundle, err);
		}
	}
	
	[self willChangeValueForKey:@"plugins"];
	_plugInBundles = pluginInstanes;
	[self didChangeValueForKey:@"plugins"];
}

#pragma mark - Plugin Callables

@end
