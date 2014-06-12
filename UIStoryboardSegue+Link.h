//
//  UIStoryboardSegue+Link.h
//  ScriptChart
//
//  Created by Ragu Vijaykumar on 5/18/13.
//  Copyright (c) 2013 Script Medical. All rights reserved.
//
//  Adds functionality to using storyboards where we can dynamically or statically link to other
//  Storyboards using segues.
//
//  Static Storyboard Linking - used when we want to call another storyboard that is known BEFORE runtime.
//  Segue must have an identifier that matches the regex pattern: StaticSL-<StoryboardName> or StaticSL-<StoryboardName>-<SceneIdentifier>
//
//  Dynamic Storyboard Linking - used when we want to call another storyboard that is known AFTER runtime
//  If you want to segue to another storyboard, but the storyboard won't be known till runtime, then use this
//  Segue must have an identifier that matches the regex pattern: *DynamicSL*
//  In the code base, before the segue is called, set the StoryboardName and Scene Identifier using the class setters
//  and these targets will be invoked when the segue is invoked.

#import <UIKit/UIKit.h>

@interface UIStoryboardSegue (Link)

// Call once per application run, before any segues are called
// A good place would be in main before launching any custom code
+ (BOOL)link;

// Use for dynamic storyboard linking only
// @required storyboardName - target storyboard filename without the *.storyboard.
// @optional sceneIdentifier - target scene to launch to in the target storyboard.
//      If @"" or nil, will use the initial view controller in target storyboard
+ (void)setStoryboardName:(NSString*)storyboardName;
+ (void)setScene:(NSString*)sceneIdentifier;

@end
