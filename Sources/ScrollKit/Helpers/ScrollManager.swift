//
//  ScrollManager.swift
//  ScrollKit
//
//  Created by Gabriel Ribeiro on 2025-04-06.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// A class that manages programmatic scrolling within a
/// scroll view that uses sticky headers.
///
/// `ScrollManager` can be used to scroll to specific
/// parts of a scroll view (e.g. the sticky header or
/// the main content) using a `ScrollViewProxy`.
///
/// To use it, inject an instance into a compatible scroll
/// view like `ScrollViewWithStickyHeader`, which will
/// register its internal proxy with the manager on appear.
///
/// You can then call `scrollToHeader()` or
/// `scrollToContent()` from your view model or UI logic
/// to trigger animated scrolling actions.
///
/// - Important: `ScrollManager` uses `ScrollViewReader`
///   under the hood, so the scrollable views must have
///   valid `.id(...)` values matching the internal targets.
public class ScrollManager {

    /// Creates a new scroll manager instance.
    public init() { }

    private var proxy: ScrollViewProxy?

    /// Scroll to the sticky header in the scroll view.
    ///
    /// - Parameter anchor: The anchor point to scroll to,
    ///   defaulting to `.top`.
    public func scrollToHeader(anchor: UnitPoint = .top) {
        withAnimation {
            proxy?.scrollTo(ScrollTargets.header, anchor: anchor)
        }
    }

    /// Scroll to the main content in the scroll view.
    ///
    /// - Parameter anchor: The anchor point to scroll to,
    ///   defaulting to `.top`.
    public func scrollToContent(anchor: UnitPoint = .top) {
        withAnimation {
            proxy?.scrollTo(ScrollTargets.content, anchor: anchor)
        }
    }

    /// Set the internal scroll proxy.
    ///
    /// This method is intended for internal use by views
    /// like `ScrollViewWithStickyHeader`.
    ///
    /// - Parameter proxy: The `ScrollViewProxy` to store.
    internal func setProxy(_ proxy: ScrollViewProxy) {
        self.proxy = proxy
    }

    /// Internal scroll target identifiers.
    enum ScrollTargets {
        static let header = "scrollkit-target-header"
        static let content = "scrollkit-target-content"
    }
}
