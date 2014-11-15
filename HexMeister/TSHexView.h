//
//  TSHexView.h
//  HexMeister
//
//  Created by Tristan Seifert on 11/14/14.
//  Copyright (c) 2014 Tristan Seifert. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TSHexView : NSView {
	
}

@property (nonatomic, readonly) CGFloat rowHeight;

@property (nonatomic, readonly) NSUInteger byteGrouping;
@property (nonatomic, readonly) BOOL overwriteMode;

@property (nonatomic, readwrite) NSUInteger byteOffset;
@property (nonatomic, readwrite) NSMutableData *data;

- (IBAction) ui_byteGrouping:(id) sender;
- (IBAction) ui_overwriteMode:(id) sender;

@end
