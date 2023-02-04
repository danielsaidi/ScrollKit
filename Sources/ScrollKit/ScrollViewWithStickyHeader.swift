//
//  ScrollViewWithStickyHeader.swift
//  ScrollKit
//
//  Created by Daniel Saidi on 2023-02-03.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This scroll view lets you provide a header view that sticks
 to the top when the scroll view scrolls.

 This view uses a ``ScrollViewWithOffset`` to get the scroll
 offset, then uses this information to determine how much of
 the header that should be visible.

 This view uses a ``ScrollViewHeader``m which means that the
 header will stretch out when the scroll view is pulled down.

 You can use `onScroll` to provide a function that is called
 whenever the view scrolls. The function receives the scroll
 view offset and a "header visible ratio" that indicates how
 much of the header that is visible. `0` and below indicates
 that the header is scrolled beyond by the nav bar, `1` that
 it is at its original positition and `1` and above that the
 scroll view is being pulled down.

 > Note: This scroll view will apply the `inline` navigation
 view title display mode, since the large title style is not
 applicable when you have a sticky header.
 */
public struct ScrollViewWithStickyHeader<Header: View, Content: View>: View {

    /**
     Create a scroll view with a sticky header.

     - Parameters:
       - axes: The scroll axes to use, by default `.vertical`.
       - header: The scroll view header builder.
       - headerHeight: The height to apply to the scroll view header.
       - headerMinHeight: The minimum height to apply to the scroll view header, by default `nil`.
       - showsIndicators: Whether or not to show scroll indicators, by default `true`.
       - onScroll: An action that will be called whenever the scroll offset changes, by default `nil`.
       - content: The scroll view content builder.
     */
    public init(
        _ axes: Axis.Set = .vertical,
        @ViewBuilder header: @escaping () -> Header,
        headerHeight: CGFloat,
        headerMinHeight: CGFloat? = nil,
        showsIndicators: Bool = true,
        onScroll: ScrollAction? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.axes = axes
        self.showsIndicators = showsIndicators
        self.header = header
        self.headerHeight = headerHeight
        self.headerMinHeight = headerMinHeight
        self.onScroll = onScroll
        self.content = content
    }

    private let axes: Axis.Set
    private let showsIndicators: Bool
    private let header: () -> Header
    private let headerHeight: CGFloat
    private let headerMinHeight: CGFloat?
    private let onScroll: ScrollAction?
    private let content: () -> Content

    public typealias ScrollAction = (_ offset: CGPoint, _ headerVisibleRatio: CGFloat) -> Void

    @State
    private var navigationBarHeight: CGFloat = 0

    @State
    private var scrollOffset: CGPoint = .zero

    private var headerVisibleRatio: CGFloat {
        (headerHeight + scrollOffset.y) / headerHeight
    }

    public var body: some View {
        ZStack(alignment: .top) {
            scrollView
            navbarOverlay
                .ignoresSafeArea(edges: .top)
                .frame(minHeight: headerMinHeight)
        }
        .prefersTransparentNavigationBar()
        .navigationBarTitleDisplayMode(.inline)
    }
}

private extension ScrollViewWithStickyHeader {

    var headerView: some View {
        header().frame(height: headerHeight)
    }

    @ViewBuilder
    var navbarOverlay: some View {
        if (headerVisibleRatio <= 0) {
            Color.clear
                .frame(height: navigationBarHeight)
                .overlay(scrollHeader, alignment: .bottom)
        } else {
            Color.clear
        }
    }

    var scrollView: some View {
        GeometryReader { proxy in
            ScrollViewWithOffset(onScroll: handleScrollOffset) {
                VStack(spacing: 0) {
                    scrollHeader
                    content()
                }
            }
            .onAppear {
                DispatchQueue.main.async {
                    navigationBarHeight = proxy.safeAreaInsets.top
                }
            }
        }
    }

    var scrollHeader: some View {
        ScrollViewHeader {
            header()
        }.frame(height: headerHeight)
    }

    func handleScrollOffset(_ offset: CGPoint) {
        self.scrollOffset = offset
        self.onScroll?(offset, headerVisibleRatio)
    }
}

struct ScrollViewWithStickyHeader_Previews: PreviewProvider {

    struct Preview: View {

        @State
        private var scrollOffset: CGPoint = .zero

        @State
        private var headerVisibleRatio: CGFloat = 1

        let headerHeight: CGFloat = 250

        var body: some View {
            NavigationView {
                ScrollViewWithStickyHeader(
                    header: header,
                    headerHeight: headerHeight,
                    onScroll: handleScrollOffset
                ) {
                    VStack {
                        ForEach(1...100, id: \.self) {
                            Text("\($0)").frame(maxWidth: .infinity)
                            Divider()
                        }
                    }.padding()
                }
                .navigationTitle("\(scrollOffset.y) | \(headerVisibleRatio)")
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Demo Title")
                            .previewHeaderContent()
                            .opacity(1 - headerVisibleRatio)
                    }
                }
            }
        }

        func header() -> some View {
            ZStack(alignment: .bottomLeading) {
                LinearGradient(colors: [.blue, .yellow], startPoint: .topLeading, endPoint: .bottom)
                LinearGradient(colors: [.clear, .black.opacity(0.2)], startPoint: .top, endPoint: .bottom)
                headerTitle.previewHeaderContent()
            }
        }

        var headerTitle: some View {
            VStack(alignment: .leading, spacing: 5) {
                Text("Demo Title").font(.largeTitle)
                Text("Some additional information")
            }
            .padding(20)
            .opacity(headerVisibleRatio)
        }

        func handleScrollOffset(_ offset: CGPoint, headerVisibleRatio: CGFloat) {
            self.scrollOffset = offset
            self.headerVisibleRatio = headerVisibleRatio
        }
    }

    static var previews: some View {
        Preview()
    }
}

private extension View {

    func previewHeaderContent() -> some View {
        self.foregroundColor(.white)
            .shadow(color: .black.opacity(0.4), radius: 1, x: 1, y: 1)
    }

    @ViewBuilder
    func prefersTransparentNavigationBar() -> some View {
        if #available(iOS 16.0, *) {
            self.toolbarBackground(.hidden, for: .navigationBar)
        } else {
            self
        }
    }
}
