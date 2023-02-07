//
//  SpotifyPreviewScreen.swift
//  ScrollKit
//
//  Created by Daniel Saidi on 2023-02-07.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

@available(iOS 15.0, *)
struct SpotifyPreviewScreen: View {

    @State
    private var scrollOffset: CGPoint = .zero

    @State
    private var headerVisibleRatio: CGFloat = 1

    var body: some View {
        NavigationView {
            scrollView
                .navigationTitle("\(scrollOffset.y) | \(headerVisibleRatio)")
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        toolbarTitle
                    }
                }
        }
        .accentColor(.white)
        .colorScheme(.dark)
    }

    var scrollView: some View {
        ScrollViewWithStickyHeader(
            header: scrollViewHeader,
            headerHeight: SpotifyPreviewHeader.height,
            onScroll: handleScrollOffset
        ) {
            SpotifyPreviewContent()
        }
    }

    func scrollViewHeader() -> some View {
        SpotifyPreviewHeader(
            headerVisibleRatio: headerVisibleRatio
        )
    }

    var toolbarTitle: some View {
        Text("We've Come for You All")
            .font(.headline.bold())
            .opacity(1-headerVisibleRatio)
    }

    func handleScrollOffset(_ offset: CGPoint, headerVisibleRatio: CGFloat) {
        self.scrollOffset = offset
        self.headerVisibleRatio = headerVisibleRatio
    }
}
