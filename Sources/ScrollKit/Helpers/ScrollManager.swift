//
//  ScrollManager.swift
//  ScrollKit
//
//  Created by Gabriel Ribeiro on 2025-04-06.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This class can be used for programmatic scrolling within a scroll view.
///
/// This manager can be used to scroll to a specific part of a scroll view's content,
/// like the header view, or the main content view, usinc a `ScrollViewProxy`.
///
/// To use this, simply add a ``ScrollTarget`` ID to your scroll view's header
/// view and content then call any manager instance's ``setProxy(_:)`` with
/// the scroll view proxy from any scroll view reader in your view.
///
/// You can then use ``scroll(to:anchor:)`` to scroll to any targets within
/// your scroll view's content view.
///
/// > Important: The scroll manager uses a `ScrollViewReader`, so the scroll
/// view must apply valid `.id(...)` values to the header and its content.
public class ScrollManager {

    /// Creates a new scroll manager instance.
    public init() { }

    /// The currently configured scroll view proxy, if any.
    public private(set) var proxy: ScrollViewProxy?
    
    /// Scroll to any target within .
    ///
    /// - Parameters:
    ///   - target: The target to scroll to.
    ///   - anchor: The anchor point to scroll to, by default `.top`.
    public func scroll(
        to target: ScrollTarget,
        anchor: UnitPoint = .top
    ) {
        withAnimation {
            proxy?.scrollTo(target, anchor: anchor)
        }
    }

    /// Set the internal scroll proxy.
    public func setProxy(_ proxy: ScrollViewProxy) {
        self.proxy = proxy
    }

    /// Internal scroll target identifiers.
    public enum ScrollTarget: String {
        case header, content
    }
}

public extension View {
    
    /// Register the view as a scroll target.
    func scrollTarget(
        _ target: ScrollManager.ScrollTarget
    ) -> some View {
        self.id(target)
    }
}
