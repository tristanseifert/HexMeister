//
//  TSDataType.h
//  HexMeister
//
//	Delegate that plugins are expected to implement, if they expose a custom
//	data type to the editor.
//
//  Created by Tristan Seifert on 11/18/14.
//  Copyright (c) 2014 Tristan Seifert. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TSDataType <NSObject>

/**
 * Returns the number of bytes required to successfully convert from the type
 * represented by the data type.
 *
 * @param identifier Identifier of data type.
 *
 * @note Return -1 for no limit, 0 for any, or any other number for a concrete
 * limitation. Data is truncated if it is greater than zero.
 */
- (NSInteger) sizeForDataType:(NSString *) identifier;

/**
 * Returns the display name of the specified data type for the "conversion bar"
 * at the bottom of the editor. (e.g. "Signed 16-bit Integer")
 */
- (NSString *) displayNameForDataType:(NSString *) identifier;

/**
 * Converts the current selection to a string to be displayed.
 *
 * A converter may also implement dataType:viewForSelection to return a custom
 * view to be displayed to the right of the string in the table cell.
 */
- (NSString *) dataType:(NSString *) identifier stringForSelection:(NSData *) selection;

/**
 * Optionally returns a view to display alongside a data type. This could be
 * used, for example, to show the colour value of an RGB tuple.
 *
 * @note This function needn't be implemented, or may return nil.
 */
- (NSView *) dataType:(NSString *) identifier viewForSelection:(NSData *) selection;

@end
