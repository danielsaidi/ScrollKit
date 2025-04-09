//
//  ScrollViewWithOffsetTracking.swift
//  ScrollKit
//
//  Created by Daniel Saidi on 2023-02-03.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This view wraps a native scroll view, and will track its
/// scroll offset as it's scrolled.
///
/// You can use the `onScroll` init parameter to pass in any
/// function that should be called whenever the view scrolls.
public struct ScrollViewWithOffsetTracking<Content: View>: View {

    /// Create a scroll view with offset tracking.
    ///
    /// - Parameters:
    ///   - axes: The scroll axes to use, by default `.vertical`.
    ///   - showsIndicators: Whether or not to show scroll indicators, by default `true`.
    ///   - onScroll: An action that will be called whenever the scroll offset changes, by default `nil`.
    ///   - content: The scroll view content.
    public init(
        _ axes: Axis.Set = .vertical,
        showsIndicators: Bool = true,
        onScroll: ScrollAction? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.axes = axes
        self.showsIndicators = showsIndicators
        self.onScroll = onScroll ?? { _ in }
        self.content = content
    }

    private let axes: Axis.Set
    private let showsIndicators: Bool
    private let onScroll: ScrollAction
    private let content: () -> Content

    public typealias ScrollAction = @MainActor @Sendable (_ offset: CGPoint) -> Void

    public var body: some View {
        ScrollView(axes, showsIndicators: showsIndicators) {
            ScrollViewOffsetTracker {
                content()
            }
        }
        .scrollViewOffsetTracking(action: onScroll)
    }
}

#Preview {

    struct Preview: View {

        @State
        var scrollOffset: CGPoint = .zero

        var body: some View {
            NavigationView {
                #if os(macOS)
                Color.clear
                #endif
                ScrollViewWithOffsetTracking(onScroll: updateScrollOffset) {
                    LazyVStack {
                        ForEach(1...100, id: \.self) {
                            Divider()
                            Text("\($0)")
                        }
                    }
                }
                .navigationTitle("\(Int(scrollOffset.y))")
            }
        }

        func updateScrollOffset(_ offset: CGPoint) {
            self.scrollOffset = offset
        }
    }

    return Preview()
}
