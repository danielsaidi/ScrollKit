//
//  Examples+SpotifyAlbumScreenHeader.swift
//  ScrollKit
//
//  Created by Daniel Saidi on 2023-02-06.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Examples.Spotify.AlbumScreen {
    
    /// This view mimics a Spotify album screen header.
    struct Header: View {
        
        public init(
            album: Examples.Spotify.Album,
            bottomPadding: Double = 0,
            visibleHeaderRatio: CGFloat = 1
        ) {
            self.album = album
            self.bottomPadding = bottomPadding
            self.visibleHeaderRatio = visibleHeaderRatio
        }
        
        public static let height: CGFloat = 280
        
        private let album: Examples.Spotify.Album
        private let bottomPadding: Double
        private let visibleHeaderRatio: CGFloat
        
        public var body: some View {
            ZStack {
                ScrollViewHeaderGradient(album.tintColor, .black)
                ScrollViewHeaderGradient(album.tintColor.opacity(1), album.tintColor.opacity(0))
                    .opacity(1 - visibleHeaderRatio)
                cover
                    .padding(.bottom, bottomPadding)
            }
        }
    }
}

private extension Examples.Spotify.AlbumScreen.Header {

    var cover: some View {
        AsyncImage(
            url: URL(string: album.releaseCoverUrl),
            content: { image in
                image.image?.resizable()
                    .aspectRatio(contentMode: .fit)
            }
        )
        .aspectRatio(1, contentMode: .fit)
        .cornerRadius(5)
        .shadow(radius: 10)
        .rotation3DEffect(.degrees(rotationDegrees), axis: (x: 1, y: 0, z: 0))
        .offset(y: verticalOffset)
        .opacity(visibleHeaderRatio)
        .padding(.top, 60)
        .padding(.bottom, 20)
        .padding(.horizontal, 20)
    }

    var rotationDegrees: CGFloat {
        guard visibleHeaderRatio > 1 else { return 0 }
        let value = 20.0 * (1 - visibleHeaderRatio)
        return value.capped(to: -5...0)
    }

    var verticalOffset: CGFloat {
        guard visibleHeaderRatio < 1 else { return 0 }
        return 70.0 * (1 - visibleHeaderRatio)
    }
}

private extension CGFloat {

    func capped(to range: ClosedRange<Self>) -> Self {
        if self < range.lowerBound { return range.lowerBound }
        if self > range.upperBound { return range.upperBound }
        return self
    }
}

#Preview {

    Examples.Spotify.AlbumScreen.Header(album: .anthrax)
        .frame(height: Examples.Spotify.AlbumScreen.Header.height)
}
