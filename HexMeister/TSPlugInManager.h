//
//  TSPlugInManager.h
//  HexMeister
//
//  Created by Tristan Seifert on 11/14/14.
//  Copyright (c) 2014 Tristan Seifert. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TSDataType;

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


/**
 * Registers a custom data type. Data types can format the selection into some
 * other data that is displayed below the raw data.
 *
 * For example, a formatter could read sequences of three bytes, and parse it as
 * an RGB tuple—returning a view indicating this colour.
 */
- (void) registerCustomDataTypeWithIdentifier:(NSString *) id andDelegate:(id<TSDataType>) delegate;

@end
