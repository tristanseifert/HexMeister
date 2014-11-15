//
//  TSDocument.m
//  HexMeister
//
//  Created by Tristan Seifert on 11/13/14.
//  Copyright (c) 2014 Tristan Seifert. All rights reserved.
//

#import "TSHexView.h"

#import "TSDocument.h"

@interface TSDocument ()

@end

@implementation TSDocument

/**
 * Initialises a "new" document.
 */
- (instancetype) init {
    self = [super init];
    if (self) {
		// create dummy data for new documents
		_data = [NSMutableData dataWithCapacity:1024];
    }
    return self;
}

/**
 * Initialises the UI after being loaded.
 */
- (void) windowControllerDidLoadNib:(NSWindowController *) aController {
	[super windowControllerDidLoadNib:aController];
	
	// update the editor view's data
	DDAssert(_data, @"Document must have data");
	_hexView.data = _data;
}

/**
 * Required to support Versions.
 */
+ (BOOL) autosavesInPlace {
	return YES;
}

/**
 * Rely on NSDocument to load our NSWindowController, using the specified NIB.
 */
- (NSString *) windowNibName {
	return @"TSDocument";
}

/**
 * Writes out the data currently in the editor view back to the original file.
 */
- (BOOL) writeToURL:(NSURL *) url ofType:(NSString *) typeName
			  error:(NSError *__autoreleasing *) outError {
	[NSException raise:@"UnimplementedMethod" format:@"%@ is unimplemented", NSStringFromSelector(_cmd)];
	
	return YES;
}

/**
 * Reads the contents of the specified file into the editor view.
 *
 * @note Maps the file in memory, if it is over a certain (configurable) size,
 * for performance reasons.
 */
- (BOOL) readFromURL:(NSURL *) url ofType:(NSString *) typeName
			   error:(NSError *__autoreleasing *) outError {
	NSError *err = nil;
	
	// Convert URL to fs path
	NSString *path = url.path;
	path = [path stringByResolvingSymlinksInPath];
	
	// Get the filesize
	NSFileManager *fm = [NSFileManager defaultManager];
	NSDictionary *attr = [fm attributesOfItemAtPath:path error:&err];
	unsigned long long size;
	
	if(!err) {
		size = attr.fileSize;
	} else {
		if(outError) *outError = err;
		return NO;
	}
	
	// Load either as a memory-mapped file, or read it all to memory now.
	NSUInteger sizeThreshold = [[NSUserDefaults standardUserDefaults] integerForKey:@"minMappedFileSize"];
	
	if(size > sizeThreshold) {
		_data = [NSMutableData dataWithContentsOfURL:url
											 options:NSDataReadingMappedIfSafe
											   error:&err];
		
		if(err) {
			if(outError) *outError = err;
			return NO;
		}
	} else {
		_data = [NSMutableData dataWithContentsOfURL:url options:0
											   error:&err];
		
		if(err) {
			if(outError) *outError = err;
			return NO;
		}
	}
	
	return YES;
}

#pragma mark - Menu Validation
/**
 * Validates a menu item's action, and updates its state, if required.
 */
- (BOOL) validateMenuItem:(NSMenuItem *) item {	
	if(item.action == @selector(ui_jumpTo:)) {
		return YES;
	}
	
	return NO;
}

#pragma mark - Menu Actions
/**
 * Opens the "Jump To…" sheet.
 */
- (IBAction) ui_jumpTo:(id) sender {
	
}

#pragma mark - Split View Delegate
- (CGFloat) splitView:(NSSplitView *) splitView
constrainSplitPosition:(CGFloat) proposedPosition
		  ofSubviewAt:(NSInteger) dividerIndex {
	if(proposedPosition < 50.f) {
		return 50.f;
	} else if(proposedPosition > (splitView.frame.size.height - 50.f)) {
		return (splitView.frame.size.height - 50.f);
	} else {
		return proposedPosition;
	}
}

@end
