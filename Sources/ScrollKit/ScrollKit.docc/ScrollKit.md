# ``ScrollKit``

ScrollKit adds powerful scrolling features to `SwiftUI`, such as scroll offset tracking and scroll view headers that stretch out as you pull down and stick to the top when you scroll.


## Overview

![Library logotype](Logo.png)

ScrollKit has a ``ScrollViewWithOffset`` that provides you with the scroll view offset, a ``ScrollViewHeader`` that automatically stretches out when the scroll view is pulled down, and a ``ScrollViewWithStickyHeader`` that pins the header view to the top as it is scrolled below the navigation bar.

ScrollKit's views are designed to be easy to use, and basically just add more properties to the standard SwiftUI `ScrollView`. They can be used on all Apple platforms, including iOS, macOS, tvOS and watchOS.

ScrollKit supports `iOS 14`, `macOS 11`, `tvOS 14` and `watchOS 7`.



## Installation

ScrollKit can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/ScrollKit.git
```

If you prefer to not have external dependencies, you can also just copy the source code into your app.



## Getting started

The <doc:Getting-Started> article has a guide to help you get started with ScrollKit.



## Repository

For more information, source code, and to report issues, sponsor the project etc., visit the [project repository](https://github.com/danielsaidi/ScrollKit).



## About this documentation

The online documentation is currently iOS only. To generate documentation for other platforms, open the package in Xcode, select a simulator then run `Product/Build Documentation`.



## License

ScrollKit is available under the MIT license. See the [LICENSE][License] file for more info.



## Topics

### Articles

- <doc:Getting-Started>

### Views

- ``ScrollViewWithOffset``
- ``ScrollViewWithStickyHeader``
- ``ScrollViewHeader``
- ``ScrollViewHeaderGradient``

### Status Bar

- ``StatusBarVisibileState``
- ``StatusBarVisibilityUpdater``

### Previews

- ``SpotifyPreviewInfo``
- ``SpotifyPreviewScreen``
- ``SpotifyPreviewScreenContent``
- ``SpotifyPreviewScreenHeader``



[License]: https://github.com/danielsaidi/ScrollKit/blob/master/LICENSE
