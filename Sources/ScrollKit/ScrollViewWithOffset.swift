//
//  ScrollViewWithOffset.swift
//  ScrollKit
//
//  Created by Daniel Saidi on 2023-02-03.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This scroll view wraps a native `ScrollView` and tracks its
 scroll offset as it scrolls.

 You can use the `onScroll` initializer parameter to provide
 a function that will be called whenever the view scrolls.
 */
public struct ScrollViewWithOffset<Content: View>: View {

    /**
     Create a scroll view with offset tracking.

     - Parameters:
       - axes: The scroll axes to use, by default `.vertical`.
       - showsIndicators: Whether or not to show scroll indicators, by default `true`.
       - onScroll: An action that will be called whenever the scroll offset changes, by default `nil`.
       - content: The scroll view content.
     */
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
        ScrollView(axes, showsIndicators: showsIndicators) {
            ZStack(alignment: .top) {
                ScrollViewOffsetTracker()
                content()
            }
        }.withOffsetTracking(action: onScroll)
    }
}

private struct ScrollViewOffsetTracker: View {

    var body: some View {
        GeometryReader { geo in
            Color.clear
                .preference(
                    key: ScrollOffsetPreferenceKey.self,
                    value: geo.frame(in: .named(ScrollOffsetNamespace.namespace)).origin
                )
        }
        .frame(height: 0)
    }
}

private extension ScrollView {

    func withOffsetTracking(
        action: @escaping (_ offset: CGPoint) -> Void
    ) -> some View {
        self.coordinateSpace(name: ScrollOffsetNamespace.namespace)
            .onPreferenceChange(ScrollOffsetPreferenceKey.self, perform: action)
    }
}

private enum ScrollOffsetNamespace {

    static let namespace = "scrollView"
}

private struct ScrollOffsetPreferenceKey: PreferenceKey {

    static var defaultValue: CGPoint = .zero

    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {}
}

struct ScrollViewWithOffset_Previews: PreviewProvider {

    struct Preview: View {

        @State
        private var scrollOffset: CGPoint = .zero

        var body: some View {
            #if os(iOS)
            NavigationView {
                contentView
                    .navigationTitle(offsetTitle)
            }
            #else
            VStack {
                Text(offsetTitle)
                contentView
            }
            #endif
        }

        var contentView: some View {
            ScrollViewWithOffset(onScroll: updateScrollOffset) {
                LazyVStack {
                    ForEach(1...100, id: \.self) {
                        Divider()
                        Text("\($0)")
                    }
                }
            }
        }

        var offsetTitle: String {
            "Offset: \(Int(scrollOffset.y))"
        }

        func updateScrollOffset(_ offset: CGPoint) {
            self.scrollOffset = offset
        }
    }

    static var previews: some View {
        Preview()
    }
}
