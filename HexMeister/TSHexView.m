//
//  TSHexView.m
//  HexMeister
//
//  Created by Tristan Seifert on 11/14/14.
//  Copyright (c) 2014 Tristan Seifert. All rights reserved.
//

#import "TSHexView.h"

@implementation TSHexView

#pragma mark - Drawing
/**
 * Draws the current row.
 */
- (void) drawRect:(NSRect) dirtyRect {
    [super drawRect:dirtyRect];
	
	[[NSColor redColor] set];
	NSRectFill(dirtyRect);
}

/**
 * Sanitize the view layout: put (0, 0) at top left instead of bottom left.
 */
- (BOOL) isFlipped {
	return YES;
}

#pragma mark - Setters/Getters
/**
 * Updates the data that is rendered. This forces a redraw of the UI, and resets
 * the cursor position to offset zero.
 */
- (void) setData:(NSMutableData *) data {
	DDAssert(data, @"data cannot be nil");
	
	_data = data;
	_byteOffset = 0;
	
	DDLogVerbose(@"New data, length %lu", (unsigned long) data.length);
	
	[self setNeedsDisplay:YES];
}

/**
 * Updates the current byte offset. Forces a redraw.
 */
- (void) setByteOffset:(NSUInteger) byteOffset {
	DDAssert(byteOffset <= _data.length, @"Byte offset larger than data!");
	
	_byteOffset = byteOffset;
	
	[self setNeedsDisplay:YES];
}

#pragma mark - UI Validation
/**
 * Validates a menu item's action, and updates its state, if required.
 */
- (BOOL) validateMenuItem:(NSMenuItem *) item {
	if(item.action == @selector(ui_byteGrouping:)) {
		if([item tag] == _byteGrouping) {
			item.state = NSOnState;
		} else {
			item.state = NSOffState;
		}
		
		return YES;
	} else if(item.action == @selector(ui_overwriteMode:)) {
		item.state = _overwriteMode ? NSOnState : NSOffState;
		return YES;
	}
	
	return NO;
}

#pragma mark - UI Actions
/**
 * Updates the byte grouping state.
 */
- (IBAction) ui_byteGrouping:(id) sender {
	_byteGrouping = ((NSMenuItem *) sender).tag;
}

/**
 * Changes between overwrite and insert mode.
 */
- (IBAction) ui_overwriteMode:(id) sender {
	_overwriteMode = !_overwriteMode;
}

/**
 * Indicates that we can indeed become first responder.
 */
- (BOOL) acceptsFirstResponder {
	return YES;
}

#pragma mark - Scrolling
/**
 * Implements mouse drag events to handle selection.
 */
-(void) mouseDragged:(NSEvent *) event {
	NSPoint dragLocation;
	dragLocation = [self convertPoint:event.locationInWindow
							 fromView:nil];
 
	// support automatic scrolling by calling autoscroll
	[self autoscroll:event];
 
	// act on the drag as appropriate to the application
}

/**
 * Constrain scrolling to 16px "rows."
 */
- (NSRect) adjustScroll:(NSRect) proposedVisibleRect {
	NSRect modifiedRect = proposedVisibleRect;
 
	// snap to 16 pixel increments vertically
	modifiedRect.origin.y = (modifiedRect.origin.y / 16.f) * 16.f;
 
	// return the modified rectangle
	return modifiedRect;
}

/**
 * Returns the intrinsic content size: i.e. the size used by the scroll view to
 * calculate scroll bars. This is essentially a calculation to determine how
 * many 16-pixel rows are needed to express the entire document.
 */
- (NSSize) intrinsicContentSize {
	NSSize scrollViewSize = self.enclosingScrollView.bounds.size;
	
	scrollViewSize.height = 1337;
	
	return scrollViewSize;
}

@end
