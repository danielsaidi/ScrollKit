# Getting Started

ScrollKit is a SwiftUI library that adds powerful scrolling features to SwiftUI, such as offset tracking and sticky scroll header views.


## Overview

ScrollKit has a ``ScrollViewWithOffset`` that provides you with the scroll view offset as it's scrolled, a ``ScrollViewWithStickyHeader`` that pins the header view to the top as it is scrolled below the navigation bar and a ``ScrollViewHeader`` that automatically stretches out when the scroll view is pulled down.

The scroll views are designed to be easy to use, and basically just add more properties to the standard SwiftUI `ScrollView`. They can be used on all Apple platforms, including iOS, macOS, tvOS and watchOS. 



## How to track the scroll offset

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


## How to set up a scroll view with a sticky header

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
        ZStack {
            Color.black
            Color.blue.opacity(1-headerVisibleRatio)  // Fades in
            Color.yellow.opacity(headerVisibleRatio)  // Fades out
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



## More views

Other than these views, you can use the ``ScrollViewHeader`` in a regular `ScrollView` to create a header that stretches out when the scroll view is pulled down, but scrolls away together with the rest of the scroll view content.

The library also has a ``ScrollViewHeaderGradient``, which is just a convenience if you want to add a gradient to the header view. This is sometimes needed when you use a background image where light or dark parts of the image can make the text content hard to read.
