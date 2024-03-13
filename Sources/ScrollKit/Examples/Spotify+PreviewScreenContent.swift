//
//  Spotify+PreviewScreenContent.swift
//  ScrollKit
//
//  Created by Daniel Saidi on 2023-02-06.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Spotify {
    
    /// This view mimics a Spotify album screen content view.
    struct PreviewScreenContent: View {
        
        public init(info: PreviewInfo) {
            self.info = info
        }
        
        private let info: PreviewInfo
        
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

private extension Spotify.PreviewScreenContent {

    var title: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(info.releaseTitle)
                .font(.title2.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(info.bandName)
                .font(.footnote.bold())
            Text("\(info.releaseType) · \(info.releaseDate.formatted(.dateTime.year()))")
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
            ForEach(Array(info.tracks.enumerated()), id: \.offset) {
                listItem($0.element)
            }
        }
    }

    func listItem(_ song: String) -> some View {
        VStack(alignment: .leading) {
            Text(song).font(.headline)
            Text(info.bandName)
                .font(.footnote)
                .foregroundColor(.secondary)
        }
    }
}

struct SpotifyPreviewScreenContent_Previews: PreviewProvider {

    static var previews: some View {
        ScrollView {
            Spotify.PreviewScreenContent(info: .anthrax)
        }
    }
}
