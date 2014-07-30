UINavigationBar + FixedHeightWhenStatusBarHidden
==============================================

Normally on iOS 7+ navigation bar height equals to 64 px, when status bar is shown. After it is hidden, the height is changed to 44 px by default.

This category adds property `fixedHeightWhenStatusBarHidden` to UINavigationBar class. If set to YES navigation bar will keep its size even if status bar was hidden.

This is especially useful in case of "drawer"-styled side panel, when you want status bar to be hidden when this panel is shown.
