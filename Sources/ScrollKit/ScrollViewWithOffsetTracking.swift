//
//  ScrollViewWithOffsetTracking.swift
//  ScrollKit
//
//  Created by Daniel Saidi on 2023-02-03.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
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

    public typealias ScrollAction = (_ offset: CGPoint) -> Void

    public var body: some View {
        if #available(
            iOS 18.0,
            macOS 15.0,
            tvOS 18.0,
            visionOS 2.0,
            watchOS 11.0,
            *
        ) {
            ScrollViewReader { proxy in
                ZStack(alignment: .top) {
                    ScrollView(axes, showsIndicators: showsIndicators) {
                        content()
                    }
                }
                .onScrollGeometryChange(for: Bool.self) { geometry in
                    let adjustedOffsetY: CGPoint = CGPoint(x: 0, y: -(geometry.contentOffset.y + geometry.contentInsets.top))
                    onScroll(adjustedOffsetY)
                    
                    return geometry.contentOffset.y > geometry.contentInsets.top
                } action: { oldValue, newValue in }
            }
        } else {
            ScrollView(axes, showsIndicators: showsIndicators) {
                ScrollViewOffsetTracker {
                    content()
                }
            }
            .withScrollOffsetTracking(action: onScroll)
        }
    }
}

#Preview("iOS 18") {

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


#Preview {

    struct Preview: View {

        @State
        var scrollOffset: CGPoint = .zero

        var body: some View {
            NavigationView {
                #if os(macOS)
                Color.clear
                #endif
                ScrollView(.vertical, showsIndicators: true) {
                    ScrollViewOffsetTracker {
                        LazyVStack {
                            ForEach(1...100, id: \.self) {
                                Divider()
                                Text("\($0)")
                            }
                        }
                    }
                }
                .withScrollOffsetTracking(action: updateScrollOffset)
                .navigationTitle("\(Int(scrollOffset.y))")
            }
        }

        func updateScrollOffset(_ offset: CGPoint) {
            self.scrollOffset = offset
        }
    }

    return Preview()
}
