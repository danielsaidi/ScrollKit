# Release Notes

ScrollKit will use semver after 1.0. 

Until then, deprecated features may be removed in the next minor version.



## 0.3

This minor update adds utilities for handling the status bar.

### ✨ New Features

* `StatusBarVisibleState` is a new observable class for handling status bar visibility.



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
