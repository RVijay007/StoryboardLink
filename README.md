Adds functionality to using storyboards where we can dynamically or statically link to other
Storyboards using segues.

**Usage:**

1.) In main.c, `#import "UIStoryboard+Segue.h"` and in the main function, activate the storyboard linking as follows:

    #import "UIStoryboard+Segue.h"
    int main(int argc, char *argv[]) {
        @autoreleasepool {
            [UIStoryboardSegue link];
            return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        }
    }
    
**Static Storyboard Linking** - used when we want to call another storyboard that is known BEFORE runtime.
Segue must have an identifier that matches the regex pattern: StaticSL-`StoryboardName` or StaticSL-`StoryboardName`-`SceneIdentifier`.

In the storyboard where you will transition to another storyboard, create the segue type you want to an empty view controller, click on the segue, and set its identifier `StaticSL-StoryboardName` or `StaticSL-StoryboardName-SceneIdentifier`. The first will activate the initialViewController in the storyboard `StoryboardName`, and the latter will activate the viewController identified by `SceneIdentifier` in the storyboard `StoryboardName`.
    
Nothing needs to be done in code.

**Dynamic Storyboard Linking** - used when we want to call another storyboard that is known AFTER runtime
If you want to segue to another storyboard, but the storyboard won't be known till runtime, then use this
Segue must have an identifier that matches the regex pattern: *DynamicSL*
In the code base, before the segue is called, set the `StoryboardName` and `SceneIdentifier` using the class setters and these targets will be invoked when the segue is invoked.

e.g.

In the storyboard where you will transition to another storyboard, create the segue type you want to an empty view controller, click on the segue, and set its identifier `DynamicSL`. You can prefix/suffix this with any sttring you want as a personal identification of what this storyboard segue will do, but the additional information is not necessary or used by the segue link.
    
In code where you want to fire the segue:
    [UIStoryboardSegue setStoryboardName:StoryboardName];
    [UIStoryboardSegue setStoryboardName:SceneIdentifierOrNil]; // Nil will activate the initial scene of the storyboard
    [viewcontroller performSegue:SegueIdentifier sender:self];
