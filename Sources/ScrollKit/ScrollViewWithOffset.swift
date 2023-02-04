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
 */
public struct ScrollViewWithOffset<Content: View>: View {

    /**
     Create a scroll view with offset tracking.

     - Parameters:
       - axes: The scroll axes to use.
       - showsIndicators: Whether or not to show scroll indicators.
       - onScroll: An action that will be called whenever the scroll offset changes.
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
        self.onScroll = onScroll
        self.content = content
    }

    private let axes: Axis.Set
    private let showsIndicators: Bool
    private let onScroll: ScrollAction?
    private let content: () -> Content

    public typealias ScrollAction = (_ offset: CGPoint) -> Void

    public var body: some View {
        ScrollView(axes, showsIndicators: showsIndicators) {
            ZStack(alignment: .top) {
                GeometryReader { geo in
                    Color.clear
                        .preference(
                            key: ScrollOffsetPreferenceKey.self,
                            value: geo.frame(in: .named(ScrollOffsetNamespace.namespace)).origin
                        )
                }
                .frame(height: 0)

                content()
            }
        }
        .coordinateSpace(name: ScrollOffsetNamespace.namespace)
        .onPreferenceChange(ScrollOffsetPreferenceKey.self) { onScroll?($0) }
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
                        Text("\($0)").frame(maxWidth: .infinity)
                    }
                }
            }
        }

        var offsetTitle: String {
            "Offset: \(Int(scrollOffset.y))"
        }

        func updateScrollOffset(_ newValue: CGPoint) {
            self.scrollOffset = newValue
        }
    }

    static var previews: some View {
        Preview()
    }
}
