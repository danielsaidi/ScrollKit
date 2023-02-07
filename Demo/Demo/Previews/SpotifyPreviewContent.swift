//
//  SpotifyPreviewContent.swift
//  ScrollKit
//
//  Created by Daniel Saidi on 2023-02-06.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI
import ScrollKit

@available(iOS 15.0, *)
struct SpotifyPreviewContent: View {

    var body: some View {
        VStack(spacing: 20) {
            title
            buttons
            list
        }
        .padding()
    }
}

@available(iOS 15.0, *)
private extension SpotifyPreviewContent {

    var title: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("We've Come for You All")
                .font(.title2.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Anthrax")
                .font(.footnote.bold())
            Text("Album · 2003")
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
            listGroup
            listGroup
            listGroup
        }
    }

    var listGroup: some View {
        Group {
            listItem("Contact")
            listItem("What Doesn't Die")
            listItem("Superhero")
            listItem("Refuse to Be Denied")
            listItem("Safe Home")
            listItem("Any Place But Here")
            listItem("Nobody Knows Anything")
        }
    }

    func listItem(_ song: String) -> some View {
        VStack(alignment: .leading) {
            Text(song).font(.headline)
            Text("Anthrax")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
    }
}
