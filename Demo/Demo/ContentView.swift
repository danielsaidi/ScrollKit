//
//  ContentView.swift
//  ScrollKit
//
//  Created by Daniel Saidi on 2023-02-04.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI
import ScrollKit

struct ContentView: View {

    @StateObject
    private var statusBarVisibile = StatusBarVisibileState()

    var body: some View {
        NavigationStack {
            List {
                linkSection
            }
            .tint(.blue)
            .navigationTitle("Demo")
        }
        .tint(.white)
        .toolbarRole(.navigationStack)
        .statusBarVisibile(statusBarVisibile)
    }
}

private extension ContentView {

    var linkSection: some View {
        Section(header: Text("Stretchable headers")) {
            spotifyLink(.anthrax)
            spotifyLink(.misfortune)
            spotifyLink(.regina)
            imageLink
            gradientLink
            colorLink
        }
    }
}

private extension ContentView {

    var colorLink: some View {
        link("paintbrush.pointed.fill", "Short color background") {
            DemoScreen(headerHeight: 100) {
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

    func spotifyLink(_ info: SpotifyPreviewInfo) -> some View {
        link("music.note", "Spotify - \(info.bandName)") {
            SpotifyPreviewScreen(info: info)
        }
    }

    func link<Destination: View>(_ icon: String, _ title: String, to destination: () -> Destination) -> some View {
        NavigationLink(destination: destination) {
            Label(title, systemImage: icon)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
