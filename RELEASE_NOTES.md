# Release Notes

ScrollKit will use semver after 1.0. 

Until then, deprecated features may be removed in any minor version.



## 0.8.1

Thanks to [@alexmomotiuk](https://github.com/alexmomotiuk), the bottom safe area but is fixed.

### 🐛 Bug Fixes

* The bottom safe area but is fixed. 



## 0.8

Thanks to [@gabrielribeiro](https://github.com/gabrielribeiro), this version adds a `ScrollManager` that can be used to scroll to certain parts of a scroll view. 

This version also fixes a few 0.7 linting errors.

### ✨ Features

* The `ScrollManager` is a new type that can be used to scroll within a scroll view.
* The `ScrollViewWithStickyHeader` can now take a `ScrollManager` in its initializer.  

### 🐛 Bug Fixes

* This version fixes linting errors that were accidentally introduced in 0.7, since Xcode 16.3 isn't able to run build scripts.



## 0.7.1

This version fixes a few 0.7 bugs and behaviors.

### 💡 Behavior Changes

* The `ScrollViewWithStickyHeader` now defaults the minimum header height to the top safe area, instead of the header height.
* The `scrollViewHeaderWithRoundedContentMask(_:)` view extension has been renamed to `scrollViewHeaderWithRoundedContentCorners(cornerRadius:)` for clarity.

### 🐛 Bug Fixes

* The `ScrollViewWithStickyHeader` no longer prints as it scrolls.
* The `scrollViewHeaderWithRoundedContentMask(_:)` view extension didn't apply the provided corner radius. This has been fixed.



## 0.7

This version moves examples into a new namespace and renames some View extensions to make more sense.

### ✨ New Features

* The `ScrollViewWithStickyHeader` has a new `headerStretch` parameter.
* The `ScrollViewWithStickyHeader` has a new `contentCornerRadius` parameter.
* The new `scrollViewContentWithHeaderOverlap(...)` view extension can apply a header overlap to a scroll view content view.
* The new `scrollViewContentWithRoundedHeaderOverlap(...)` view extension can apply a rounded header overlap to a scroll view content view. 
* The new `scrollViewHeaderWithRoundedContentMask(...)` view extension can apply a rounded corner mask to a scroll view header. 
 
### 💡 Behavior Changes

* `ScrollViewWithStickyHeader` now wraps its content in a `GeometryReader` to properly handle scroll offset.

### 🐛 Bug Fixes

* `ScrollViewWithStickyHeader` now honors the provided min height better, by using the geometry reader safe area insets.

### 🗑️ Deprecations

* All examples have been moved into a new `Examples` namespace.
* The `hideStatusBarUntilScrolled` view extension has been renamed to `statusBarHiddenUntilScrolled`.
* The `withScrollOffsetTracking` view extension has been renamed to `scrollViewOffsetTracking`.



## 0.6.1

This version adjusts the code to address a concurrency warning.



## 0.6

This version makes ScrollKit use Swift 6.



## 0.5.1

This version adds support for strict concurrency.

Thanks to murilocappucci@gmail.com, the `ScrollViewWithStickyHeader` now properly passes on the axis and indicator parameters to `ScrollViewWithOffsetTracking`. 



## 0.5

This version makes more stuff public and adds support form visionOS.



## 0.4

This version updates to Swift 5.9, bumps deployment targets and removes CocoaPods support.

This version also moves all Spotify-related previews into a `Spotify` namespace.

### 🐛 Bug Fixes

* `ScrollViewWithStickyHeader` now honors the provided min height.

### 💥 Breaking changes

* `ScrollViewWithOffset` has been renamed to `ScrollViewWithOffsetTracking`.
* `StatusBarVisibleState` has been renamed to the correct name.



## 0.3

This update adds utilities for handling status bar visibility.

### ✨ New Features

* `StatusBarVisibleState` is a new class for handling status bar visibility with shared state, for instance when using `NavigationStack`.
* `StatusBarVisibilityUpdater` is a new view modifier to automatically update the status bar visibility depending on the current scroll state.



## 0.2

This minor update adds some public previews that you can use in your own apps.

### ✨ New Features

* `SpotifyPreviewInfo` is a new struct that defines preview info for the Spotify previews.
* `SpotifyPreviewInfo` has several pre-configured albums that you can use in the previews.                
* `SpotifyPreviewScreen`, `SpotifyPreviewHeader` and `SpotifyPreviewContent` are new preview views.



## 0.1

This is the first public release of ScrollKit.

### ✨ New Features
                
* `ScrollViewWithOffset` is a scroll view that provides you with the scroll offset.
* `ScrollViewWithStickyHeader` is a scroll view that lets you provide a sticky header view.
* `ScrollViewHeader` is a scroll view header that will automatically stretch out as the scroll view is pulled down.
* `ScrollViewHeaderGradient` is a convenience view to quickly define a header gradient, e.g. a dark overlay.
