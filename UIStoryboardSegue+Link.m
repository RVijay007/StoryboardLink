//
//  UIStoryboardSegue+Link.m
//  ScriptChart
//
//  Created by Ragu Vijaykumar on 5/18/13.
//  Copyright (c) 2013 Script Medical. All rights reserved.
//

#import "UIStoryboardSegue+Link.h"
#import "JRSwizzle.h"
#import "NSString+Helper.h"

@interface UIStoryboardSegue (LinkPrivate)
- (id)initWithLinkIdentifier:(NSString*)identifier source:(UIViewController*)source destination:(UIViewController*)destination;
@end

@implementation UIStoryboardSegue (Link)
static NSString* kStoryboardName = @"";
static NSString* kSceneIdentifier = @"";
static NSString* const kDynamicStoryboardLink = @"DynamicSL";
static NSString* const kStaticStoryboardLink = @"StaticSL";
static NSString* const kStaticStoryboardLinkSeperator = @"-";

- (id)initWithLinkIdentifier:(NSString*)identifier source:(UIViewController*)source destination:(UIViewController*)destination {
#ifdef DEBUG
    NSLog(@"Segue Identifier: %@", identifier);
#endif
    
    if([identifier contains:kDynamicStoryboardLink]) {
        NSAssert([kStoryboardName length], @"No storyboard name");
        
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:kStoryboardName bundle:nil];        
        if ([kSceneIdentifier length] == 0)
            destination = [storyboard instantiateInitialViewController];
        else
            destination = [storyboard instantiateViewControllerWithIdentifier:kSceneIdentifier];
        
        NSAssert(destination,
                 @"No scene found in storyboard: \"%@\" with optional identifier: \"%@\"",
                 kStoryboardName,
                 kSceneIdentifier);
#ifdef DEBUG
        if ([kSceneIdentifier length] == 0)
            NSLog(@"Dynamic segue to storyboard %@", kStoryboardName);
        else
            NSLog(@"Dynamic segue to scene %@ in storyboard %@", kSceneIdentifier, kStoryboardName);
#endif
        
    } else if([identifier contains:kStaticStoryboardLink]) {
        
        // Parse identifier to get storyboard name and scene identifier
        NSArray* components = [identifier componentsSeparatedByString:kStaticStoryboardLinkSeperator];
        if([components count] > 1)
            kStoryboardName = components[1];
        else
            kStoryboardName = @"";
        
        if([components count] > 2)
            kSceneIdentifier = components[2];
        else
            kSceneIdentifier = @"";
        
        NSAssert([kStoryboardName length], @"No storyboard name");
        
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:kStoryboardName bundle:nil];
        if ([kSceneIdentifier length] == 0)
            destination = [storyboard instantiateInitialViewController];
        else
            destination = [storyboard instantiateViewControllerWithIdentifier:kSceneIdentifier];
        
        NSAssert(destination,
                 @"No scene found in storyboard: \"%@\" with optional identifier: \"%@\"",
                 kStoryboardName,
                 kSceneIdentifier);
        
#ifdef DEBUG
        if ([kSceneIdentifier length] == 0)
            NSLog(@"Static segue to storyboard %@", kStoryboardName);
        else
            NSLog(@"Static segue to scene %@ in storyboard %@", kSceneIdentifier, kStoryboardName);
#endif
    }
    
    kStoryboardName = @"";
    kSceneIdentifier = @"";
    
    return [self initWithLinkIdentifier:identifier source:source destination:destination];
}

+ (void)setStoryboardName:(NSString*)storyboardName {
    if(!storyboardName)
        storyboardName = @"";
    
    kStoryboardName = [storyboardName copy];
}

+ (void)setScene:(NSString*)sceneIdentifier {
    if(!sceneIdentifier)
        sceneIdentifier = @"";
    
    kSceneIdentifier = [sceneIdentifier copy];
}

+ (BOOL)link {
    static BOOL didSwizzle = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSError* error;
        
        didSwizzle = [[self class] jr_swizzleMethod:@selector(initWithIdentifier:source:destination:)
                                         withMethod:@selector(initWithLinkIdentifier:source:destination:)
                                              error:&error];
#ifdef DEBUG
        if(!didSwizzle) {
            NSLog(@"Failed link with %@", error);
        } else {
            NSLog(@"Link succeeded on %@", [self class]);
        }
#endif
    });
    
    return didSwizzle;
}

@end
