//
//  TSIntegerPlugin.m
//  HexMeister
//
//  Created by Tristan Seifert on 11/14/14.
//  Copyright (c) 2014 Tristan Seifert. All rights reserved.
//

#import "TSIntegerPlugin.h"

@implementation TSIntegerPlugin

/**
 * Initialises the plugin, which should use the given plugin controller for
 * communications. It also passes in the bundle that the plugin is loaded from.
 *
 * @param manager Plugin manager to use for communications
 * @param bundle Bundle the plugin was loaded from.
 */
- (id) initWithPluginManager:(TSPlugInManager *) manager
				  withBundle:(NSBundle *) bundle {
	if(self = [super init]) {
		
	}
	
	return self;
}

/**
 * Returns the display name for this plugin.
 */
- (NSString *) name {
	return NSLocalizedString(@"Integer Conversions", nil);
}

/**
 * Returns a dictionary with certain keys set to indicate user information.
 */
- (NSDictionary *) userInformation {
	return nil;
}

@end
