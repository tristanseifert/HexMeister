//
//  TSPlugIn.h
//  HexMeister
//
//  Created by Tristan Seifert on 11/14/14.
//  Copyright (c) 2014 Tristan Seifert. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TSPlugInManager;
@protocol TSPlugIn <NSObject>

@required
/**
 * Initialises the plugin, which should use the given plugin controller for
 * communications. It also passes in the bundle that the plugin is loaded from.
 *
 * @param manager Plugin manager to use for communications
 * @param bundle Bundle the plugin was loaded from.
 */
- (id) initWithPluginManager:(TSPlugInManager *) manager
				  withBundle:(NSBundle *) bundle;

/**
 * Returns the display name for this plugin.
 */
- (NSString *) name;

/**
 * Returns a dictionary with certain keys set to indicate user information.
 */
- (NSDictionary *) userInformation;

@end
