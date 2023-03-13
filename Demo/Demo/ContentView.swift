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

    @State
    private var isStatusBarHidden = false

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    title
                    linkSection
                }
            }
            .tint(.blue)
            .toolbar(.hidden)
        }
        .tint(.white)
        .toolbarRole(.navigationStack)
        .statusBar(hidden: isStatusBarHidden)
    }
}

private extension ContentView {

    var title: some View {
        Text("ScrollKit Demo")
            .font(.largeTitle)
            .listRowInsets(.none)
            .listRowBackground(Color.clear)
    }

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
            DemoScreen(isStatusBarHidden: $isStatusBarHidden, headerHeight: 100) {
                Color.blue
            }
        }
    }

    var gradientLink: some View {
        link("paintbrush.fill", "Gradient background") {
            DemoScreen(isStatusBarHidden: $isStatusBarHidden, headerHeight: 250) {
                ScrollViewHeaderGradient(.yellow, .blue)
            }
        }
    }

    var imageLink: some View {
        link("photo.fill", "Image background") {
            DemoScreen(isStatusBarHidden: $isStatusBarHidden, headerHeight: 250) {
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
