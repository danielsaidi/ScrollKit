//
//  Examples+SpotifyAlbumScreenContent.swift
//  ScrollKit
//
//  Created by Daniel Saidi on 2023-02-06.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Examples.Spotify.AlbumScreen {
    
    /// This view mimics a Spotify album screen content view.
    struct Content: View {
        
        public init(album: Examples.Spotify.Album) {
            self.album = album
        }
        
        private let album: Examples.Spotify.Album
        
        public var body: some View {
            VStack(spacing: 20) {
                title
                buttons
                list
            }
            .padding()
        }
    }
}

private extension Examples.Spotify.AlbumScreen.Content {

    var title: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(album.releaseTitle)
                .font(.title2.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(album.bandName)
                .font(.footnote.bold())
            Text("\(album.releaseType) · \(album.releaseDate.formatted(.dateTime.year()))")
                .font(.footnote.bold())
                .foregroundColor(.secondary)
        }
    }

    var buttons: some View {
        HStack(spacing: 15) {
            Image(systemName: "heart")
            Image(systemName: "arrow.down.circle")
            Image(systemName: "ellipsis")
            Spacer()
            Image(systemName: "shuffle")
            Image(systemName: "play.circle.fill")
                .font(.largeTitle)
                .foregroundColor(.green)
        }
        .font(.title3)
    }

    var list: some View {
        LazyVStack(alignment: .leading, spacing: 30) {
            ForEach(Array(album.tracks.enumerated()), id: \.offset) {
                listItem($0.element)
            }
        }
    }

    func listItem(_ song: String) -> some View {
        VStack(alignment: .leading) {
            Text(song).font(.headline)
            Text(album.bandName)
                .font(.footnote)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {

    ScrollView {
        Examples.Spotify.AlbumScreen.Content(album: .anthrax)
    }
}
