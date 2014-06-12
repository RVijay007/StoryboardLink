//
//  NSString+Helper.m
//  ScriptChart
//
//  Created by Ragu Vijaykumar on 5/18/13.
//  Copyright (c) 2013 Script Medical. All rights reserved.
//

#import "NSString+Helper.h"

@implementation NSString (Helper)

- (BOOL)contains:(NSString*)substring {
    return ([self rangeOfString:substring].location != NSNotFound);
}

- (NSString*)remove:(NSString*)substring {
    return [self stringByReplacingOccurrencesOfString:substring withString:@""];
}

- (NSString*)trimmed {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)isNotEmpty {
    return ([self length] > 0);
}

- (NSString*)capitalizeFirstLetter {
    if([self isNotEmpty])
        return [self stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[self substringToIndex:1] uppercaseString]];
    else
        return self;
}

@end
