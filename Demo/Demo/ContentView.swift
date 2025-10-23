//
//  ContentView.swift
//  ScrollKit
//
//  Created by Daniel Saidi on 2023-02-04.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI
import ScrollKit

struct ContentView: View {

    var body: some View {
        NavigationStack {
            List {
                linkSection
                spotifySection
            }
            .tint(.blue)
            .navigationTitle("ScrollKit")
            .toolbarColorScheme(.light, for: .navigationBar)
        }
    }
}

private extension ContentView {

    var linkSection: some View {
        Section(header: Text("Sticky headers")) {
            imageLink
            gradientLink
            colorLink
        }
    }

    var spotifySection: some View {
        Section(header: Text("Spotify screens")) {
            spotifyLink(.anthrax)
            spotifyLink(.misfortune)
            spotifyLink(.regina)
        }
    }
}

private extension ContentView {

    var colorLink: some View {
        link("paintbrush.pointed.fill", "Color") {
            DemoScreen(headerHeight: 250) {
                Color.blue
            }
        }
    }

    var gradientLink: some View {
        link("paintbrush.fill", "Gradient") {
            DemoScreen(headerHeight: 250) {
                ScrollViewHeaderGradient(.yellow, .blue)
            }
        }
    }

    var imageLink: some View {
        link("photo.fill", "Image") {
            DemoScreen(headerHeight: 250) {
                ZStack {
                    ScrollViewHeaderImage(Image("header"))
                    ScrollViewHeaderGradient(.black.opacity(0.2), .black.opacity(0.5))
                }
            }
        }
    }

    func spotifyLink(_ info: Examples.Spotify.Album) -> some View {
        link("record.circle.fill", "Spotify - \(info.bandName)") {
            Examples.Spotify.AlbumScreen(album: info)
        }
    }

    func link<Destination: View>(_ icon: String, _ title: String, to destination: () -> Destination) -> some View {
        NavigationLink(destination: destination) {
            Label(title, systemImage: icon)
        }
    }
}

#Preview {
    ContentView()
}
