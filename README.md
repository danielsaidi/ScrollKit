<p align="center">
    <img src ="Resources/Logo_rounded.png" alt="ScrollKit Logo" title="ScrollKit" width=600 />
</p>

<p align="center">
    <img src="https://img.shields.io/github/v/release/danielsaidi/ScrollKit?color=%2300550&sort=semver" alt="Version" />
    <img src="https://img.shields.io/badge/Swift-5.7-orange.svg" alt="Swift 5.7" />
    <img src="https://img.shields.io/github/license/danielsaidi/ScrollKit" alt="MIT License" />
    <a href="https://twitter.com/danielsaidi">
        <img src="https://img.shields.io/badge/contact-@danielsaidi-blue.svg?style=flat" alt="Twitter: @danielsaidi" />
    </a>
</p>


## About ScrollKit

ScrollKit is a SwiftUI library that adds powerful scrolling features to SwiftUI, such as offset tracking and sticky scroll header views.

ScrollKit has a `ScrollViewWithOffset` that provides you with the scroll view offset as it's scrolled, a `ScrollViewWithStickyHeader` that pins the header view to the top as it is scrolled below the navigation bar and a `ScrollViewHeader` that automatically stretches out when the scroll view is pulled down.

The result can look like this, or completely different:

<p align="center" style="border-radius: 10px">
    <img src="Resources/Demo.gif" width=300 />
</p>

The scroll views are designed to be easy to use, and basically just add more properties to the standard SwiftUI `ScrollView`. They can be used on all Apple platforms, including iOS, macOS, tvOS and watchOS.



## Installation

ScrollKit can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/ScrollKit.git
```

or with CocoaPods:

```
pod DSScrollKit
```



## Supported Platforms

ScrollKit supports `iOS 14`, `macOS 11`, `tvOS 14` and `watchOS 7`.



## Getting started

The [online documentation][Documentation] has a [getting started][GettingStarted] guide to help you get started with ScrollKit.

To track the scroll offset, you can use a `ScrollViewWithOffset` instead of a regular `ScrollView`:

```swift
struct MyView: View {

    @State
    private var offset = CGPoint.zero
    
    func handleOffset(_ scrollOffset: CGPoint) {
        self.offset = scrollOffset
    }

    var body: some View {
        ScrollViewWithOffset(onScroll: handleOffset) {
            // Add your scroll view content here as regular
        }
    }
}
```

You can then use this offset in any way you like, to for instance fade in a navigation bar title. 

To create a scroll view with a sticky header, just create a `ScrollViewWithStickyHeader` and provide it with a header view and header height:

```swift
struct MyView: View {

    @State
    private var offset = CGPoint.zero
    
    @State
    private var visibleRatio = CGFloat.zero
    
    func handleOffset(_ scrollOffset: CGPoint, visibleHeaderRatio: CGFloat) {
        self.offset = scrollOffset
        self.visible = visibleHeaderRatio
    }
    
    func header() -> some View {
        ZStack(alignment: .bottomLeading) {
            Color.blue
            Color.yellow.opacity(visibleRatio)  // Fades in
        }
    }

    var body: some View {
        ScrollViewWithStickyHeader(
            header: header,
            headerHeight: 250,
            onScroll: handleOffset
        ) {
            // Add your scroll view content here as regular
        }
    }
}
```

The header visible ratio is based on the header height and scroll view offset and lets you adjust your content as the header is scrolled under the navigation bar. 



## Documentation

The [online documentation][Documentation] contains more information, code examples, etc., and makes it easy to overview the various parts of the library.



## Demo Application

This project contains a demo app that lets you explore ScrollKit on iOS and macOS. To run it, just open and run `Demo/Demo.xcodeproj`.



## Support

You can sponsor this project on [GitHub Sponsors][Sponsors] or get in touch for paid support. 



## Contact

Feel free to reach out if you have questions or if you want to contribute in any way:

* E-mail: [daniel.saidi@gmail.com][Email]
* Twitter: [@danielsaidi][Twitter]
* Web site: [danielsaidi.com][Website]



## License

ScrollKit is available under the MIT license. See the [LICENSE][License] file for more info.



[Email]: mailto:daniel.saidi@gmail.com
[Twitter]: http://www.twitter.com/danielsaidi
[Website]: http://www.danielsaidi.com
[Sponsors]: https://github.com/sponsors/danielsaidi

[Documentation]: https://danielsaidi.github.io/ScrollKit/documentation/scrollkit/
[GettingStarted]: https://danielsaidi.github.io/ScrollKit/documentation/scrollkit/getting-started
[License]: https://github.com/danielsaidi/ScrollKit/blob/master/LICENSE
