//
//  TSAppDelegate.m
//  HexMeister
//
//  Created by Tristan Seifert on 11/13/14.
//  Copyright (c) 2014 Tristan Seifert. All rights reserved.
//

#import <TSAppKit/TSAppKit.h>

#import "TSAppDelegate.h"

@interface TSAppDelegate ()

@end

@implementation TSAppDelegate

- (void) applicationDidFinishLaunching:(NSNotification *) aNotification {
	// Insert code here to initialize your application
}

- (void) applicationWillTerminate:(NSNotification *) aNotification {
	// Insert code here to tear down your application
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
