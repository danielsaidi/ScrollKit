# Getting Started

ScrollKit adds powerful scrolling features to SwiftUI, such as offset tracking and a sticky scroll header.


## Overview

ScrollKit is designed to be easy to use and works on all major Apple platforms (iOS, macOS, tvOS and watchOS).

ScrollKit is designed to be easy to use and works on all major Apple platforms (iOS, macOS, tvOS and watchOS).



## How to track scroll offset

ScrollKit has a ``ScrollViewWithOffsetTracking`` that triggers an action when it's scrolled:

```swift
struct MyView: View {

    @State
    private var offset = CGPoint.zero
    
    func handleOffset(_ scrollOffset: CGPoint) {
        self.offset = scrollOffset
    }

    var body: some View {
        ScrollViewWithOffsetTracking(onScroll: handleOffset) {
            // Add your scroll content here, e.g. a `LazyVStack`
        }
    }
}
```

You can then use this offset in any way you like, e.g. to fade in a navigation bar title.



## How to set up a sticky header

ScrollKit has a ``ScrollViewWithStickyHeader`` that stretches and transforms its header when it's pulled down, then sticks it to the top as it's scrolled.

To create a a sticky header, just use ``ScrollViewWithStickyHeader`` and provide it with a header view and header height:

```swift
struct MyView: View {

    @State
    private var offset = CGPoint.zero
    
    @State
    private var visibleRatio = CGFloat.zero
    
    func handleOffset(_ scrollOffset: CGPoint, visibleHeaderRatio: CGFloat) {
        self.offset = scrollOffset
        self.visibleRatio = visibleHeaderRatio
    }
    
    func header() -> some View {
        ZStack {
            Color.red
            ScrollViewHeaderGradient()  // By default a dark gradient
        }
    }

    var body: some View {
        ScrollViewWithStickyHeader(
            header: header,
            headerHeight: 250,
            onScroll: handleOffset
        ) {
            // Add your scroll content here, e.g. a `LazyVStack`
        }
    }
}
```

The `visibleHeaderRatio` is how many percent (1.0 to 0.0) that is visible below the navigation bar.



## More views

ScrollKit has some other views as well, for instance:

* ``ScrollViewHeader`` can be used in a regular `ScrollView` and stretches out when it's pulled down, then scrolls away together with the content.
* ``ScrollViewHeaderGradient`` is just a convenience that can be used to add a discrete gradient to the header.
