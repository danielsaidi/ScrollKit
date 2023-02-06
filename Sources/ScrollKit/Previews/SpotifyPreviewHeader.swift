//
//  SpotifyPreviewHeader.swift
//  ScrollKit
//
//  Created by Daniel Saidi on 2023-02-06.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

@available(iOS 15.0, *)
struct SpotifyPreviewHeader: View {

    static var height: CGFloat = 280

    var headerVisibleRatio: CGFloat = 1

    var body: some View {
        ScrollViewHeader {
            ZStack {
                LinearGradient(
                    colors: [.viewPurple, .black],
                    startPoint: .top,
                    endPoint: .bottom
                )
                
                AsyncImage(
                    url: URL(string: "https://upload.wikimedia.org/wikipedia/en/8/8f/AnthraxWCFYA.jpg"),
                    content: { image in
                        image.image?.resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                )
                .opacity(headerVisibleRatio)
                .aspectRatio(1, contentMode: .fit)
                .cornerRadius(5)
                .shadow(radius: 10)
                .padding(.top, 60)
                .padding(.horizontal, 20)
            }
        }
        .frame(height: Self.height)
    }
}

private extension Color {

    static var viewPurple: Color {
        .init(red: 0.5, green: 0.4, blue: 0.5)
    }
}
