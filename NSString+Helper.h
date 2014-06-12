//
//  NSString+Helper.h
//  ScriptChart
//
//  Created by Ragu Vijaykumar on 5/18/13.
//  Copyright (c) 2013 Script Medical. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Helper)

/**
 * Checks to see if the receiver contains the substring
 */
- (BOOL)contains:(NSString*)substring;

/**
 * Remove all occurances of substring in the receiver and returns the output string
 */
- (NSString*)remove:(NSString*)substring;

/**
 * Removed leading and lagging white space characters from the string
 */
- (NSString*)trimmed;

/**
 * Quick method that returns false for strings that are nil and empty strings
 */
- (BOOL)isNotEmpty;

- (NSString*)capitalizeFirstLetter;

@end
