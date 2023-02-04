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
                imageLink
                gradientLink
                colorLink
            }
            .tint(.blue)
            .navigationTitle("Demo")
        }
        .tint(.primary)
    }
}

private extension ContentView {

    var colorLink: some View {
        link("photo", "Scroll with color header") {
            DemoScreen(headerHeight: 200) {
                Color.blue
            }
        }
    }

    var gradientLink: some View {
        link("photo", "Scroll with gradient header") {
            DemoScreen(headerHeight: 250) {
                ScrollViewHeaderGradient(.yellow, .blue)
            }
        }
    }

    var imageLink: some View {
        link("photo", "Scroll with image header") {
            DemoScreen(headerHeight: 250) {
                ScrollViewHeaderImage(Image("header"))
            }
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
