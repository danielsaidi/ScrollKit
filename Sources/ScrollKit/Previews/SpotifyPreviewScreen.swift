//
//  SpotifyPreviewScreen.swift
//  ScrollKit
//
//  Created by Daniel Saidi on 2023-02-07.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view mimics the Spotify release screen.
 */
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public struct SpotifyPreviewScreen: View {

    public init(info: SpotifyPreviewInfo) {
        self.info = info
    }

    private var info: SpotifyPreviewInfo

    @State
    private var scrollOffset: CGPoint = .zero

    @State
    private var headerVisibleRatio: CGFloat = 1

    @Environment(\.dismiss)
    private var dismiss

    public var body: some View {
        ScrollViewWithStickyHeader(
            header: scrollViewHeader,
            headerHeight: SpotifyPreviewScreenHeader.height,
            onScroll: handleScrollOffset
        ) {
            SpotifyPreviewScreenContent(info: info)
        }
        .preferredColorScheme(.dark)
        #if os(iOS)
        .hideBackButtonText()
        #endif
        #if os(iOS) || os(macOS) || os(tvOS)
        .toolbarTitle(toolbarTitleView)
        #endif
    }

    func scrollViewHeader() -> some View {
        SpotifyPreviewScreenHeader(
            info: info,
            headerVisibleRatio: headerVisibleRatio
        )
    }

    var toolbarTitleView: some View {
        Text(info.releaseTitle)
            .font(.headline.bold())
            .opacity(headerVisibleRatio > 0 ? 0 : -5 * headerVisibleRatio)
    }

    func handleScrollOffset(_ offset: CGPoint, headerVisibleRatio: CGFloat) {
        self.scrollOffset = offset
        self.headerVisibleRatio = headerVisibleRatio
    }
}

private extension View {

    #if os(iOS)
    func hideBackButtonText() -> some View {
        self.toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Text("       ") // Hides the back button text :D
            }
        }
    }
    #endif

    func toolbarTitle<Title: View>(_ view: Title) -> some View {
        #if os(iOS) || os(macOS) || os(tvOS)
        self.toolbar {
            ToolbarItem(placement: .principal) {
                view
            }
        }
        #else
        self
        #endif
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
struct SpotifyPreviewScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            #if os(macOS)
            Color.clear
            #endif
            SpotifyPreviewScreen(info: .regina)
        }
    }
}
