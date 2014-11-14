//
//  main.m
//  HexMeister
//
//  Created by Tristan Seifert on 11/13/14.
//  Copyright (c) 2014 Tristan Seifert. All rights reserved.
//

#import <Cocoa/Cocoa.h>

int main(int argc, const char * argv[]) {
	// set up logging to console and TTY
	[DDLog addLogger:[DDASLLogger sharedInstance]];
	
	[DDLog addLogger:[DDTTYLogger sharedInstance]];
	[[DDTTYLogger sharedInstance] setColorsEnabled:YES];
	
	// logfiles
	DDFileLogger* fileLogger = [[DDFileLogger alloc] init];
	fileLogger.rollingFrequency = 60 * 60 * 24 * 7; // weekly rolling
	fileLogger.logFileManager.maximumNumberOfLogFiles = 24;
	//	fileLogger.logFormatter = [[SQULogFileFormatter alloc] init];
	[DDLog addLogger:fileLogger];
	
	return NSApplicationMain(argc, argv);
}
