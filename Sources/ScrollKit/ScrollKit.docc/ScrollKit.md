# ``ScrollKit``

ScrollKit is a SwiftUI library that adds powerful scrolling features to SwiftUI, such as offset tracking and sticky scroll header views.


## Overview

![SwiftKit logo](Logo.png)

ScrollKit has a ``ScrollViewWithOffset`` that provides you with the scroll view offset as it's scrolled, a ``ScrollViewWithStickyHeader`` that pins the header view to the top as it is scrolled below the navigation bar and a ``ScrollViewHeader`` that automatically stretches out when the scroll view is pulled down.

The scroll views are designed to be easy to use, and basically just add more properties to the standard SwiftUI `ScrollView`. They can be used on all Apple platforms, including iOS, macOS, tvOS and watchOS.



## Installation

ScrollKit can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/ScrollKit.git
```

or with CocoaPods:

```
pod ScrollKit
```



## Supported Platforms

ScrollKit supports `iOS 14`, `macOS 11`, `tvOS 14` and `watchOS 7`.



## About this documentation

The online documentation is currently iOS only. To generate documentation for other platforms, open the package in Xcode, select a simulator then run `Product/Build Documentation`.

Note that type extensions are not included in this documentation.



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



[License]: https://github.com/danielsaidi/ScrollKit/blob/master/LICENSE
