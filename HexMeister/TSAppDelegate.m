//
//  TSAppDelegate.m
//  HexMeister
//
//  Created by Tristan Seifert on 11/13/14.
//  Copyright (c) 2014 Tristan Seifert. All rights reserved.
//

#import <TSAppKit/TSAppKit.h>

#import "TSPlugInManager.h"
#import "TSAppDelegate.h"

@interface TSAppDelegate ()

@end

@implementation TSAppDelegate

/**
 * Initialises some application state (plugins, default preferences, etc) once
 * the application has finished launching. This is called before document
 * windows are restored.
 */
- (void) applicationDidFinishLaunching:(NSNotification *) aNotification {
	// Register defaults
	NSString *path = [[NSBundle mainBundle] pathForResource:@"DefaultPreferences"
													 ofType:@"plist"];
	NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:path];
	DDAssert(prefs, @"Couldn't load preferences defaults");
	
	[[NSUserDefaults standardUserDefaults] registerDefaults:prefs];
	
	// Load plugins
	[[TSPlugInManager sharedInstance] loadPlugins];
}

/**
 * Tears down any allocated mechanisms, such as plugins.
 */
- (void) applicationWillTerminate:(NSNotification *) aNotification {

}

/**
 * Opens preferences controller.
 */
- (IBAction) showPreferences:(id) sender {
	if(!_prefs) {
		_prefs = [[TSPreferencesController alloc] init];
	}
	
	[_prefs showWindow:sender];
}

@end
