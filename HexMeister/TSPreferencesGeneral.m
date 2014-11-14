//
//  TSPreferencesGeneral.m
//  HexMeister
//
//  Created by Tristan Seifert on 11/13/14.
//  Copyright (c) 2014 Tristan Seifert. All rights reserved.
//

#import "TSPreferencesGeneral.h"

@interface TSPreferencesGeneral ()

@end

@implementation TSPreferencesGeneral

- (id) init {
	NSBundle *bundle = [NSBundle mainBundle];
	if(self = [super initWithNibName:@"TSPreferencesGeneral" bundle:bundle]) {
		
	}
	
	return self;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

@end
