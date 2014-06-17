Adds functionality to using storyboards where we can dynamically or statically link to other
Storyboards using segues.

**Static Storyboard Linking** - used when we want to call another storyboard that is known BEFORE runtime.
Segue must have an identifier that matches the regex pattern: StaticSL-`StoryboardName` or StaticSL-`StoryboardName`-`SceneIdentifier`

**Dynamic Storyboard Linking** - used when we want to call another storyboard that is known AFTER runtime
If you want to segue to another storyboard, but the storyboard won't be known till runtime, then use this
Segue must have an identifier that matches the regex pattern: *DynamicSL*
In the code base, before the segue is called, set the `StoryboardName` and `SceneIdentifier` using the class setters and these targets will be invoked when the segue is invoked.
