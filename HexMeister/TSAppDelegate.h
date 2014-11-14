//
//  TSAppDelegate.h
//  HexMeister
//
//  Created by Tristan Seifert on 11/13/14.
//  Copyright (c) 2014 Tristan Seifert. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class TSPreferencesController;
@interface TSAppDelegate : NSObject <NSApplicationDelegate> {
	TSPreferencesController *_prefs;
}

- (IBAction) showPreferences:(id) sender;

@end

