//
//  ScrollViewWithStickyHeader.swift
//  ScrollKit
//
//  Created by Daniel Saidi on 2023-02-03.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This scroll view lets you provide a scroll view header that
 sticks to the top when the view scrolls.

 The view contains a ``ScrollViewWithOffsetTracking`` to get
 the scroll offset, which it then uses to determine how much
 of the header that's below the navigation bar. It also uses
 a ``ScrollViewHeader`` to make the header view stretch when
 the scroll view is pulled down.

 You can use `onScroll` to provide a function that is called
 whenever the view scrolls. The function receives the scroll
 view offset and a header visible ratio, which indicates how
 much of the header that is visible below the navigation bar.

 This view enforces `.navigationBarTitleDisplayMode(.inline)`
 since a large title doesn't work with a sticky header.

 > Important: `toolbarBackground(.hidden)` is applied on iOS
 16 and later, to make the navigation bar transparent. It is
 not applied on iOS 15 and earlier. This means that you must
 use another way to make the navigation bar transparent when
 you target older iOS versions. One way is to use appearance
 proxies if you can fall down to UIKit.
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
        }
        .prefersNavigationBarHidden()
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

private extension ScrollViewWithStickyHeader {
    
    var isStickyHeaderVisible: Bool {
        guard let headerMinHeight else { return headerVisibleRatio <= 0 }
        return scrollOffset.y < -headerMinHeight
    }

    @ViewBuilder
    var navbarOverlay: some View {
        if isStickyHeaderVisible {
            Color.clear
                .frame(height: navigationBarHeight)
                .overlay(scrollHeader, alignment: .bottom)
                .ignoresSafeArea(edges: .top)
                .frame(height: headerMinHeight)
        }
    }

    var scrollView: some View {
        GeometryReader { proxy in
            ScrollViewWithOffsetTracking(onScroll: handleScrollOffset) {
                VStack(spacing: 0) {
                    scrollHeader
                    content()
                        .frame(maxHeight: .infinity)
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
        ScrollViewHeader(content: header)
            .frame(height: headerHeight)
    }

    func handleScrollOffset(_ offset: CGPoint) {
        self.scrollOffset = offset
        self.onScroll?(offset, headerVisibleRatio)
    }
}

struct ScrollViewWithStickyHeader_Previews: PreviewProvider {
    
    struct Preview: View {
        
        @State
        var selection = 0
        
        func header() -> some View {
            #if canImport(UIKit)
            TabView {
                Color.red.tag(0)
                Color.green.tag(1)
                Color.blue.tag(2)
            }
            .tabViewStyle(.page)
            #else
            Color.red
            #endif
        }
        
        var body: some View {
            ScrollViewWithStickyHeader(
                .vertical,
                header: header,
                headerHeight: 250,
                headerMinHeight: 150,
                showsIndicators: false
            ) {
                LazyVStack {
                    ForEach(1...100, id: \.self) {
                        Text("\($0)")
                    }
                }
            }
        }
    }
    
    
    static var previews: some View {
        NavigationView {
            #if os(macOS)
            Color.clear
            #endif
            Preview()
        }
        .accentColor(.white)
        .colorScheme(.dark)
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
