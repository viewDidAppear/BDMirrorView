# BDMirrorView
A fast and efficient UIView subclass which renders its own reflection, live.

![BDMirrorView_hero](https://user-images.githubusercontent.com/2734719/176471316-b2ae7851-9c90-4bf6-b245-1e9332dcbc11.png)

[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg?style=for-the-badge)](https://raw.githubusercontent.com/viewDidAppear/BDMirrorView/master/LICENSE)
[![Platform](https://img.shields.io/cocoapods/p/BDMirrorView.svg?style=for-the-badge)](http://cocoadocs.org/docsets/BDMirrorView)
[![CocoaPods](https://img.shields.io/badge/pods-BDMirrorView-brightgreen?maxAge=3600&style=for-the-badge)](https://cocoapods.org/pods/BDMirrorView)
[![Twitter](https://img.shields.io/badge/twitter-follow%20me-ff69b4?style=for-the-badge)](https://twitter.com/viewDidAppear)
[![Blog](https://img.shields.io/badge/read-my%20blog-red?style=for-the-badge)](https://viewDidAppear.github.io)

---

`BDMirrorView` is a `CAReplicatorLayer`-backed `UIView` subclass which can be used to render a live content reflection in an iOS app. If you're struggling to understand why this view exists, just think back to Cover Flow (rip..) and the reflection below each item....

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

# Features

* Render a reflection on the top, left, bottom or right-hand side of the view.
* Customise the distance of the reflection from the parent.
* Use a masking gradient, or not.

# Usage

Set the class of the UIView to `BDMirrorView` in the Storyboard, or create an IBOutlet. 🙌

# Installation & Compatibility

`BDMirrorView` will work wherever this version of Swift will compile.

## Manual (aka Tried & True)

Download the repo and add it into your Xcode project.

## CocoaPods

```ruby
pod 'BDMirrorView'
```

# Why? WHY?

No reason. Have fun!

# Credits

`BDMirrorView` was created by [Benjamin Deckys](https://github.com/viewDidAppear)

# License

`BDMirrorView` is available under the MIT license. Please see the [LICENSE](LICENSE) file for more information.
