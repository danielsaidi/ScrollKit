//
//  DemoScreen.swift
//  ScrollKit
//
//  Created by Daniel Saidi on 2023-02-04.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import ScrollKit
import SwiftUI

/// This view takes a custom header view and height and adds
/// it to a scroll view with sticky header.
struct DemoScreen<HeaderView: View>: View {

    let headerHeight: CGFloat

    @ViewBuilder
    let headerView: () -> HeaderView

    @State
    private var visibleHeaderRatio: CGFloat = 1

    @State
    private var scrollOffset: CGPoint = .zero
    
    private let scrollManager = ScrollManager()

    var body: some View {
        ScrollViewWithStickyHeader(
            header: header,
            headerHeight: headerHeight,
            // headerMinHeight: 50,
            scrollManager: scrollManager,
            onScroll: handleScrollOffset
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
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Demo Title")
                    .font(.headline)
                    .previewHeaderContent()
                    .opacity(1 - visibleHeaderRatio)
            }
        }
        .toolbarBackground(.hidden)
        .statusBarHidden(scrollOffset.y > -3)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }

    func header() -> some View {
        ZStack(alignment: .bottomLeading) {
            headerView()
            ScrollViewHeaderGradient()
            headerTitle.previewHeaderContent()
        }
    }

    var headerTitle: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Demo Title").font(.largeTitle)
            Text("Some additional information")
        }
        .padding(20)
        .opacity(visibleHeaderRatio)
    }

    func handleScrollOffset(_ offset: CGPoint, visibleHeaderRatio: CGFloat) {
        self.scrollOffset = offset
        self.visibleHeaderRatio = visibleHeaderRatio
    }
}

#Preview {

    NavigationView {
        DemoScreen(
            headerHeight: 250,
            headerView: {
                ScrollViewHeaderImage(Image("header"))
            }
        )
    }
}

private extension View {

    func previewHeaderContent() -> some View {
        self.foregroundColor(.white)
            .shadow(color: .black.opacity(0.4), radius: 1, x: 1, y: 1)
    }
}
