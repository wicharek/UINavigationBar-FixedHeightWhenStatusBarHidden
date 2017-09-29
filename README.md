# UINavigationBar-FixedHeightWhenStatusBarHidden

[![Version](https://img.shields.io/cocoapods/v/UINavigationBar-FixedHeightWhenStatusBarHidden.svg?style=flat)](http://cocoapods.org/pods/UINavigationBar-FixedHeightWhenStatusBarHidden)
[![License](https://img.shields.io/cocoapods/l/UINavigationBar-FixedHeightWhenStatusBarHidden.svg?style=flat)](http://cocoapods.org/pods/UINavigationBar-FixedHeightWhenStatusBarHidden)
[![Platform](https://img.shields.io/cocoapods/p/UINavigationBar-FixedHeightWhenStatusBarHidden.svg?style=flat)](http://cocoapods.org/pods/UINavigationBar-FixedHeightWhenStatusBarHidden)

Normally on iOS 7+ navigation bar height equals to 64 px, when status bar is shown. After it is hidden, the height is changed to 44 px by default.

This category adds property `fixedHeightWhenStatusBarHidden` to UINavigationBar class. If set to YES navigation bar will keep its size even if status bar was hidden.

This is especially useful in case of "drawer"-styled side panel, when you want status bar to be hidden when this panel is shown.

## Installation

<b>Manual:</b>
<br>
Add to your project source files from `UINavigationBar-FixedHeightWhenStatusBarHidden` folder
<br>
<br>
<b>CocoaPods:</b>
<br>
<i>UINavigationBar-FixedHeightWhenStatusBarHidden</i> is available through [CocoaPods](http://cocoapods.org). To install
it, add the following line to your Podfile:
<pre>
pod 'UINavigationBar-FixedHeightWhenStatusBarHidden'
</pre>

## How to use

Add `#import "UINavigationBar+FixedHeightWhenStatusBarHidden.h"` to the header of a view controller file

Enable fixed height with:
```objective-c
self.navigationController.navigationBar.fixedHeightWhenStatusBarHidden = YES;
```

On iOS 11+ you should also set correct additional safe area insets on each view controller presented inside `UINavigationController` with fixed height enabled. This can be done by overriding `viewWillLayoutSubviews` of `UIViewController`. Then you can install the required insets automatically:
```objective-c
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self.navigationController.navigationBar setAdditionalSafeAreaInsetsForViewController:self];	
}
```

Or in case you need to customize insets, use `[UINavigationBar additionalSafeAreaInsets]` selector to get insets required for fixed height to work and modify them according to your needs:
```objective-c
- (void)viewWillLayoutSubviews {
   [super viewWillLayoutSubviews];

    if (@available(iOS 11.0, *)) {
        UIEdgeInsets navigationBarSafeAreaInsets = [self.navigationController.navigationBar additionalSafeAreaInsets];
        self.additionalSafeAreaInsets = UIEdgeInsetsMake(navigationBarSafeAreaInsets.top + 20, 0, 0, 0);
    }
}
```

## License

<i>UINavigationBar-FixedHeightWhenStatusBarHidden</i> is available under the MIT license. See the LICENSE file for more info.
