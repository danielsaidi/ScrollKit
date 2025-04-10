//
//  ScrollViewWithStickyHeader.swift
//  ScrollKit
//
//  Created by Daniel Saidi on 2023-02-03.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This scroll view lets you inject a header view that will
/// stick to the top when the view scrolls.
///
/// The view wraps a ``ScrollViewWithOffsetTracking`` to get
/// scroll offset that it then uses to determine how much of
/// the header that's below the navigation bar. It also uses
/// a ``ScrollViewHeader`` to make your header view properly
/// stretch out when the scroll view is pulled down.
///
/// You can apply a `headerHeight` which will be the resting
/// height of the header, a `headerMinHeight` as the minimum
/// header height (below the top safe area), and an optional
/// `contentCornerRadius` which applies a corner radius mask
/// under which the scroll view content will scroll. You can
/// also set the `headerStretch` parameter to `false` if you
/// prefer to disable the header stretch effect. This can be
/// nice when the view is rendered in a sheet, where pulling
/// down should dismiss the sheet rather than stretching the
/// sticky header.
///
/// You can use the `onScroll` init parameter to pass in any
/// function that should be called whenever the view scrolls.
/// The function is called with the scroll view offset and a
/// "header visible ratio", which indicates how much of your
/// header that is visible below the navigation bar.
///
/// This view will automatically use an inline title display
/// mode, since it doesn't work for a large nativation title.
///
/// > Important: `toolbarBackground(.hidden)` is applied for
/// iOS 16 and later, to make the navigation bar transparent.
/// It's not applied on iOS 15 and earlier, which means that
/// you must use another way to make the bar transparent for
/// older iOS versions. One way is to use appearance proxies
/// if you can fall down to UIKit.
public struct ScrollViewWithStickyHeader<Header: View, Content: View>: View {

    /// Create a scroll view with a sticky header.
    ///
    /// - Parameters:
    ///   - axes: The scroll axes to use, by default `.vertical`.
    ///   - header: The scroll view header builder.
    ///   - headerHeight: The height to apply to the scroll view header.
    ///   - headerMinHeight: The minimum height to apply to the scroll view header, by default the `top safe area insets`.
    ///   - headerStretch: Whether to stretch out the header when pulling down, by default `true`.
    ///   - contentCornerRadius: The corner radius to apply to the scroll content.
    ///   - showsIndicators: Whether or not to show scroll indicators, by default `true`.
    ///   - scrollManager: A class that manages programmatic scrolling to header or content.
    ///   - onScroll: An action that will be called whenever the scroll offset changes, by default `nil`.
    ///   - content: The scroll view content builder.
    public init(
        _ axes: Axis.Set = .vertical,
        @ViewBuilder header: @escaping () -> Header,
        headerHeight: Double,
        headerMinHeight: Double? = nil,
        headerStretch: Bool = true,
        contentCornerRadius: CGFloat = 0,
        showsIndicators: Bool = true,
        scrollManager: ScrollManager? = nil,
        onScroll: ScrollAction? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.axes = axes
        self.showsIndicators = showsIndicators
        self.header = header
        self.headerHeight = headerHeight
        self.headerMinHeight = headerMinHeight
        self.headerStretch = headerStretch
        self.contentCornerRadius = contentCornerRadius
        self.scrollManager = scrollManager
        self.onScroll = onScroll
        self.content = content
    }

    private let axes: Axis.Set
    private let showsIndicators: Bool
    private let header: () -> Header
    private let headerHeight: Double
    private let headerMinHeight: Double?
    private let headerStretch: Bool
    private let contentCornerRadius: CGFloat
    private let scrollManager: ScrollManager?
    private let onScroll: ScrollAction?
    private let content: () -> Content
    
    public typealias ScrollAction = (_ offset: CGPoint, _ visibleHeaderRatio: CGFloat) -> Void
    
    @State
    private var scrollOffset: CGPoint = .zero

    private var visibleHeaderRatio: CGFloat {
        let value = (headerHeight + scrollOffset.y) / headerHeight
        if headerStretch { return value }
        return min(1, value)
    }

    public var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                scrollView(in: geo)
                navbarOverlay(in: geo)
            }
            .edgesIgnoringSafeArea(.all)
        }
        .prefersNavigationBarHidden()
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

@MainActor
private extension ScrollViewWithStickyHeader {
    
    func headerMinHeight(
        in geo: GeometryProxy
    ) -> Double {
        let minHeight = headerMinHeight ?? 0
        let safeMinHeight = minHeight + geo.safeAreaInsets.top
        return min(safeMinHeight, headerHeight)
    }
    
    func isStickyHeaderVisible(
        in geo: GeometryProxy
    ) -> Bool {
        let minHeight = headerMinHeight(in: geo)
        return scrollOffset.y < -minHeight
    }

    func navbarOverlay(
        in geo: GeometryProxy
    ) -> some View {
        let minHeight = headerMinHeight(in: geo)
        let ratioHeight = headerHeight * visibleHeaderRatio
        return Color.clear.overlay(alignment: .bottom) {
            scrollHeader
        }
        .frame(height: max(minHeight, ratioHeight))
        .ignoresSafeArea(edges: .top)
    }

    func scrollView(
        in geo: GeometryProxy
    ) -> some View {
        ScrollViewReader { scrollProxy in
            ScrollViewWithOffsetTracking(
                axes,
                showsIndicators: showsIndicators,
                onScroll: handleScrollOffset
            ) {
                VStack(spacing: 0) {
                    scrollHeader
                        .opacity(0)
                        .id(ScrollManager.ScrollTargets.header)
                    content()
                        .frame(maxHeight: .infinity)
                        .id(ScrollManager.ScrollTargets.content)
                }
            }
            .onAppear {
                scrollManager?.setProxy(scrollProxy)
            }
        }
    }
    
    @ViewBuilder
    var scrollHeader: some View {
        if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
            scrollHeaderView
                .scrollViewHeaderWithRoundedContentCorners(
                    cornerRadius: contentCornerRadius
                )
        } else {
            scrollHeaderView
        }
    }
    
    @ViewBuilder
    var scrollHeaderView: some View {
        ScrollViewHeader(content: header)
            .frame(minHeight: headerHeight)
            .edgesIgnoringSafeArea(.all)
    }

    func handleScrollOffset(_ offset: CGPoint) {
        self.scrollOffset = offset
        self.onScroll?(offset, visibleHeaderRatio)
    }
}

#Preview("Demo") {
    ScrollViewWithStickyHeader(
        header: { Color.red },
        headerHeight: 200,
        headerMinHeight: nil
    ) {
        LazyVStack(spacing: 0) {
            ForEach(1...100, id: \.self) { item in
                VStack(spacing: 0) {
                    Text("Item \(item)")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Divider()
                }
            }
        }
    }
}

#Preview("Navigation") {
    
    return NavigationView {
        #if os(macOS)
        Color.clear
        #endif
        Preview(isInSheet: false)
    }
    #if os(iOS)
    .navigationViewStyle(.stack)
    #endif
}

#Preview("Sheet") {
 
    struct SheetPreview: View {
        
        @State var isPresented = true
        
        var body: some View {
            Button("Present") {
                isPresented.toggle()
            }
            .sheet(isPresented: $isPresented) {
                Preview(isInSheet: true)
            }
        }
    }
    
    return SheetPreview()
}

private struct Preview: View {
    
    let isInSheet: Bool
    
    @State var visibleHeaderRatio = 0.0
    @State var scrollOffset = CGPoint.zero
     
    let contentCornerRadius = 20.0
    
    func header() -> some View {
        #if canImport(UIKit)
        TabView {
            Group {
                headerPageView(.red).tag(0)
                headerPageView(.green).tag(1)
                headerPageView(.blue).tag(2)
            }
            .edgesIgnoringSafeArea(.all)
        }
        .tabViewStyle(.page)
        #else
        VStack {
            Color.blue
            Color.red
        }
        #endif
    }
    
    func headerPageView(
        _ color: Color
    ) -> some View {
        LinearGradient(
            colors: [color, .black],
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    var body: some View {
        ScrollViewWithStickyHeader(
            .vertical,
            header: header,
            headerHeight: 250,
            headerMinHeight: 100,
            headerStretch: false,
            contentCornerRadius: 10, //contentCornerRadius,
            showsIndicators: false,
            onScroll: { offset, visibleHeaderRatio in
                self.scrollOffset = offset
                self.visibleHeaderRatio = visibleHeaderRatio
            }
        ) {
            LazyVStack {
                ForEach(1...100, id: \.self) {
                    Text("\($0)")
                }
            }
        }
        .overlay {
            VStack {
                Text("Offset: \(scrollOffset.y)")
                Text("Ratio: \(visibleHeaderRatio)")
            }
            .background(Color.yellow)
        }
    }
}

private extension View {

    @ViewBuilder
    func prefersNavigationBarHidden() -> some View {
        #if os(watchOS)
        self
        #else
        if #available(iOS 16.0, macOS 13.0, tvOS 16.0, *) {
            self.toolbarBackground(.hidden)
        } else {
            self
        }
        #endif
    }
}
