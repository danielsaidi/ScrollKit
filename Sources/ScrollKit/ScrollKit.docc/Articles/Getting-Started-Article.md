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


## Basic Usage

The most basic use-case is to use the top-level ``ScrollViewWithStickyHeader`` to set up a sticky header within any list or scroll view, then use ``ScrollViewHeaderImage`` and ``ScrollViewHeaderGradient`` to easily manage the stretching.

There are however many other scroll utilities in this library. Some have been replaced by native SwiftUI features that have been added after this library was first released, but are kept due to backwards compatibility. 



## How to track scroll offset

Althouth there are native alternatives, ScrollKit has a ``ScrollViewWithOffsetTracking`` that triggers an action when it's scrolled:

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

You can also use the ``ScrollViewOffsetTracker`` together with the ``SwiftUICore/View/scrollViewOffsetTracking(action:)`` view modifier:

```swift
List {
    ScrollViewOffsetTracker {
        ForEach(0...100, id: \.self) {
            Text("\($0)")
                .frame(width: 200, height: 200)
        }
    }
}
.scrollViewOffsetTracking { offset in
    print(offset)
}
```

You use the offset in any way you like, e.g. to fade navigation bar title. This is how ``ScrollViewWithStickyHeader`` is implemented.



## How to set up a scroll view with a sticky header

You can use the ``ScrollViewWithStickyHeader`` view to create a scroll view that has a header view that stretches and transforms when it's pulled down, and sticks to the top as the scroll view content is scrolled:

```swift
struct MyView: View {

    @State
    private var offset = CGPoint.zero
    
    @State
    private var visibleRatio = CGFloat.zero

    var body: some View {
        ScrollViewWithStickyHeader(
            header: stickyHeader,   // A header view
            headerHeight: 250,      // The resting header height
            headerMinHeight: 150,   // The minimum header height
            headerStretch: false,   // Disables the stretch effect
            contentCornerRadius: 20 // An optional corner radius mask
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
            Text("Scroll offset: \(offset.y)")
        }
    }
}
```

The visibleHeaderRatio is how many percent (0-1) that is visible below the navigation bar. You can use this to adjust the header content.



## How to set up a scroll view with a header and overlapping content

A common design pattern is to apply rounded corners to the scroll content, and have it overlay the scroll view header. You can use the ``SwiftUICore/View/scrollViewHeaderRoundedOverlap(_:cornerRadius:)`` view extension to achieve this effect:

![Screenshot](Rounded-Corners)

ScrollKit also has a ``SwiftUICore/View/scrollViewHeaderOverlap(_:)`` variant that just applies the overlap, withough any other view modifications. 



## How to fade in the status bar on scroll

Since it's complicated to control the appearance of a status bar in an app that supports both light and dark mode, and there are some glitches when the scroll offset is zero, ScrollKit has ways to hide the status bar until the view scrolls.

Just add a ``StatusBarVisibleState`` to your view, and apply a ``SwiftUICore/View/statusBarVisible(_:)`` view modifier to the root content. The status bar will then automatically update as you scroll. 


```swift
struct ContentView: View {

    @StateObject
    private var state = StatusBarVisibleState()

    var body: some View {
        NavigationStack {
            ...
        }
        .statusBarVisible(state)
    }
}
```

You can also just use the ``SwiftUICore/View/statusBarHiddenUntilScrolled(offset:)`` modifier, which will automatically set up everything and handle the state on scroll.

Note that this is an experimental feature that may contain glitches based on where you use it. Please report any strange behavior if you find that this utility doesn't work as intended in certain scenarios.



## More views

ScrollKit has some additional views as well. The ``ScrollViewHeader`` can be used in a regular `ScrollView` and stretches out when it's pulled down, then scrolls away with the content. The ``ScrollViewHeaderGradient`` can be used as a discrete color gradient on top of a header image, to ensure readabilkity. The ``ScrollViewHeaderImage`` takes any custom image and adjusts it to be presented as a stretchy scroll view header.


## More view extensions


