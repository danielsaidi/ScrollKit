# Getting Started

ScrollKit adds powerful scrolling features to SwiftUI, such as offset tracking and a sticky scroll header.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )

    @PageColor(blue)
}


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

ScrollKit has a ``ScrollViewWithStickyHeader`` that stretches and transforms when it's pulled down, and sticks it to the top when its scroll view is scrolled.

To use a sticky header, just add one to a view and provide it with a content view, a start height, an optional minimum height, etc.:

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
            headerMinHeight: 150,
            onScroll: handleOffset
        ) {
            // Add your scroll content here, e.g. a `LazyVStack`
        }
    }
}
```

The `visibleHeaderRatio` is how many percent (1.0 to 0.0) that is visible below the navigation bar. You can use this information to transform the content in the header accordingly.



## More views

ScrollKit has some other views as well, for instance:

@TabNavigator {
   @Tab("ScrollViewHeader") {
       Can be used in a regular `ScrollView` and stretches out when it's pulled down, then scrolls away together with the content.
   }

   @Tab("ScrollViewHeaderGradient") {
       A convenience that can be used to add a discrete gradient to the header.
   }
   
   @Tab("ScrollViewHeaderImage") {
       Takes any image and adjusts it to be presented as a scroll view header.
   }
}
