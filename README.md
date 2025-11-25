<p align="center">
    <img src="Resources/Icon-Badge.png" alt="Project Icon" width="250" />
</p>

<p align="center">
    <img src="https://img.shields.io/github/v/release/danielsaidi/ScrollKit?color=%2300550&sort=semver" alt="Version" title="Version" />
    <img src="https://img.shields.io/badge/swift-6.1-orange.svg" alt="Swift 6.1" />
    <a href="https://danielsaidi.github.io/ScrollKit"><img src="https://img.shields.io/badge/documentation-web-blue.svg" alt="Documentation" /></a>
    <a href="https://github.com/danielsaidi/ScrollKit/blob/master/LICENSE"><img src="https://img.shields.io/github/license/danielsaidi/ScrollKit" alt="MIT License" /></a>
</p>


# ScrollKit

ScrollKit is a SwiftUI library that adds powerful scroll features, like offset tracking and a header view that stretches & transforms as you pull down, and sticks to the top when you scroll.

<p align="center" style="border-radius: 10px">
    <img src="Resources/Demo.gif" width=425 />
</p>

ScrollKit works on all major Apple platforms and is designed to be easy to use. It doesn't use the new `ScrollView` APIs for backwards compatibility reasons, but will eventually do so.


## Installation

ScrollKit can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/ScrollKit.git
```


## Getting started

ScrollKit has a `ScrollViewWithOffsetTracking` that can detect scrolling on all OS versions:

```swift
ScrollViewWithOffsetTracking { offset in
    print(offset)
} content: {
    // Add your scroll content here, e.g. a `LazyVStack`
}
```

ScrollKit has a `ScrollViewWithStickyHeader` that makes it easy to set up a stretchy, sticky header:

```swift
import SwiftUI
import ScrollKit

struct MyView: View {

    @State
    private var scrollOffset = CGPoint.zero

    @State
    private var visibleRatio = CGFloat.zero

    var body: some View {
        ScrollViewWithStickyHeader(
            header: stickyHeader,   // A header view
            headerHeight: 250,      // The resting header height
            headerMinHeight: 150,   // The minimum header height
            headerStretch: false,   // Disables the stretch effect
            contentCornerRadius: 20, // An optional corner radius mask
            onScroll: handleScroll  // An optional scroll handler action
        ) {
            // Add your scroll content here, e.g. a `LazyVStack`
        }
    }

    func handleScroll(_ offset: CGPoint, visibleHeaderRatio: CGFloat) {
        self.scrollOffset = offset
        self.visibleRatio = visibleHeaderRatio
    }

    func stickyHeader() -> some View {
        ZStack {
            Color.red
            ScrollViewHeaderGradient()  // By default a dark gradient
            Text("Scroll offset: \(scrollOffset.y)")
        }
    }
}
```

For more information, please see the [getting started guide][Getting-Started].


## Documentation

The [online documentation][Documentation] has more information, articles, code examples, etc.


## Demo Application

The demo app lets you explore the library. To try it out, just open and run the `Demo` project.


## Support My Work

You can [become a sponsor][Sponsors] to help me dedicate more time on my various [open-source tools][OpenSource]. Every contribution, no matter the size, makes a real difference in keeping these tools free and actively developed.


## Contact

Feel free to reach out if you have questions or want to contribute in any way:

* Website: [danielsaidi.com][Website]
* E-mail: [daniel.saidi@gmail.com][Email]
* Bluesky: [@danielsaidi@bsky.social][Bluesky]
* Mastodon: [@danielsaidi@mastodon.social][Mastodon]


## License

ScrollKit is available under the MIT license. See the [LICENSE][License] file for more info.


[Email]: mailto:daniel.saidi@gmail.com
[Website]: https://danielsaidi.com
[GitHub]: https://github.com/danielsaidi
[OpenSource]: https://danielsaidi.com/opensource
[Sponsors]: https://github.com/sponsors/danielsaidi

[Bluesky]: https://bsky.app/profile/danielsaidi.bsky.social
[Mastodon]: https://mastodon.social/@danielsaidi
[Twitter]: https://twitter.com/danielsaidi

[Documentation]: https://danielsaidi.github.io/ScrollKit/
[Getting-Started]: https://danielsaidi.github.io/ScrollKit/documentation/scrollkit/getting-started-article
[License]: https://github.com/danielsaidi/ScrollKit/blob/master/LICENSE
