//
//  ContentView.swift
//  ScrollKit
//
//  Created by Daniel Saidi on 2023-02-04.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import SwiftUI
import ScrollKit

struct ContentView: View {

    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Stretchable headers")) {
                    spotifyLink
                    imageLink
                    gradientLink
                    colorLink
                }
            }
            .tint(.blue)
            .navigationTitle("ScrollKit")
            .navigationBarTitleDisplayMode(.inline)
        }
        .tint(.white)
    }
}

private extension ContentView {

    var colorLink: some View {
        link("paintbrush.pointed.fill", "Color background") {
            DemoScreen(headerHeight: 200) {
                Color.blue
            }
        }
    }

    var gradientLink: some View {
        link("paintbrush.fill", "Gradient background") {
            DemoScreen(headerHeight: 250) {
                ScrollViewHeaderGradient(.yellow, .blue)
            }
        }
    }

    var imageLink: some View {
        link("photo.fill", "Image background") {
            DemoScreen(headerHeight: 250) {
                ZStack {
                    ScrollViewHeaderImage(Image("header"))
                    ScrollViewHeaderGradient(.black.opacity(0.2), .black.opacity(0.5))
                }
            }
        }
    }

    var spotifyLink: some View {
        link("music.note", "Spotify album screen") {
            SpotifyPreviewScreen()
        }
    }

    func link<Destination: View>(
        _ iconName: String,
        _ title: String,
        to destination: () -> Destination
    ) -> some View {
        NavigationLink(destination: destination) {
            Label(title, systemImage: iconName)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
