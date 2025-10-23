//
//  Examples+SpotifyAlbumScreen.swift
//  ScrollKit
//
//  Created by Daniel Saidi on 2023-02-07.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Examples.Spotify {
    
    /// This view mimics a Spotify album screen.
    struct AlbumScreen: View {
        
        public init(album: Album) {
            self.album = album
        }
        
        private var album: Album
        
        @Environment(\.colorScheme) private var colorScheme
        @Environment(\.dismiss) private var dismiss

        @State private var visibleHeaderRatio = 1.0
        @State private var scrollOffset = CGPoint.zero

        private var scrollContentCornerRadius: Double {
            colorScheme == .dark ? 0.0 : 20
        }
        
        public var body: some View {
            ScrollViewWithStickyHeader(
                header: scrollViewHeader,
                headerHeight: Examples.Spotify.AlbumScreen.Header.height,
                headerMinHeight: 50,
                headerStretch: true,
                contentCornerRadius: scrollContentCornerRadius,
                onScroll: handleScrollOffset
            ) {
                if #available(iOS 16.0, *) {
                    Examples.Spotify.AlbumScreen.Content(album: album)
                }
            }
            #if os(iOS) || os(macOS) || os(tvOS)
            .toolbarTitle(toolbarTitleView)
            #endif
        }
        
        func scrollViewHeader() -> some View {
            Examples.Spotify.AlbumScreen.Header(
                album: album,
                bottomPadding: scrollContentCornerRadius,
                visibleHeaderRatio: visibleHeaderRatio
            )
        }
        
        var toolbarTitleView: some View {
            Text(album.releaseTitle)
                .font(.headline.bold())
                .opacity(visibleHeaderRatio > 0 ? 0 : -5 * visibleHeaderRatio)
        }
        
        func handleScrollOffset(_ offset: CGPoint, visibleHeaderRatio: CGFloat) {
            self.scrollOffset = offset
            self.visibleHeaderRatio = visibleHeaderRatio
        }
    }
}

private extension View {

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

private struct Preview: View {
    
    var body: some View {
        Examples.Spotify.AlbumScreen(album: .misfortune)
    }
}

#Preview("Light") {

    Preview()
}

#Preview("Dark") {

    Preview().preferredColorScheme(.dark)
}

#Preview("Push") {

    NavigationView {
        #if os(macOS)
        Color.clear
        #endif
        NavigationLink("Test") {
            Preview()
        }
    }
    #if os(iOS)
    .navigationViewStyle(.stack)
    #endif
}

#if os(iOS)
#Preview("Sheet") {
    
    struct SheetPreview: View {
        
        @State var isPresented = false
        
        var body: some View {
            Button("Present") {
                isPresented.toggle()
            }
            .sheet(isPresented: $isPresented) {
                NavigationView {
                    Preview()
                }
                .navigationViewStyle(.stack)
            }
        }
    }
    
    return SheetPreview()
}
#endif
