//
//  TSDocument.h
//  HexMeister
//
//  Created by Tristan Seifert on 11/13/14.
//  Copyright (c) 2014 Tristan Seifert. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class TSHexView;
@interface TSDocument : NSDocument <NSSplitViewDelegate> {
	IBOutlet TSHexView *_hexView;
}

@property (nonatomic, readonly) NSMutableData *data;

- (IBAction) ui_jumpTo:(id) sender;

@end

