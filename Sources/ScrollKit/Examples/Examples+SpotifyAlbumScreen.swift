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
        
        @Environment(\.dismiss)
        private var dismiss
        
        @State
        private var visibleHeaderRatio = 1.0
        
        @State
        private var scrollOffset = CGPoint.zero
        
        public var body: some View {
            ScrollViewWithStickyHeader(
                header: scrollViewHeader,
                headerHeight: Examples.Spotify.AlbumScreen.Header.height,
                onScroll: handleScrollOffset
            ) {
                Examples.Spotify.AlbumScreen.Content(album: album)
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
            Examples.Spotify.AlbumScreen.Header(
                album: album,
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

private var previewAlbum: Examples.Spotify.Album { .misfortune }

#Preview("Plain") {

    Examples.Spotify.AlbumScreen(album: previewAlbum)
}

#Preview("Push") {

    NavigationView {
        #if os(macOS)
        Color.clear
        #endif
        NavigationLink("Test") {
            Examples.Spotify.AlbumScreen(album: previewAlbum)
        }
    }
    #if os(iOS)
    .navigationViewStyle(.stack)
    #endif
}

#if os(iOS)
#Preview("Sheet") {
    
    struct Preview: View {
        
        @State var isPresented = false
        
        var body: some View {
            Button("Present") {
                isPresented.toggle()
            }
            .sheet(isPresented: $isPresented) {
                NavigationView {
                    Examples.Spotify.AlbumScreen(album: previewAlbum)
                }
                .navigationViewStyle(.stack)
            }
        }
    }
    
    return Preview()
}
#endif

