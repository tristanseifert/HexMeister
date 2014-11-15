//
//  TSPlugInManager.h
//  HexMeister
//
//  Created by Tristan Seifert on 11/14/14.
//  Copyright (c) 2014 Tristan Seifert. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSPlugInManager : NSObject {
	NSMutableArray *_plugInBundles;
}

@property (nonatomic, readonly) NSArray *plugins;

/// Returns shared instance
+ (instancetype) sharedInstance;

/**
 * Loads the plugins that were discovered previously.
 */
- (void) loadPlugins;

@end
