//
//  SpotifyPreviewHeader.swift
//  ScrollKit
//
//  Created by Daniel Saidi on 2023-02-06.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI
import ScrollKit

@available(iOS 15.0, *)
struct SpotifyPreviewHeader: View {

    static var height: CGFloat = 280

    var headerVisibleRatio: CGFloat = 1

    var body: some View {
        ScrollViewHeader {
            ZStack {
                ScrollViewHeaderGradient(.viewPurple, .black)
                ScrollViewHeaderGradient(.viewPurple.opacity(0.5), .viewPurple.opacity(0))
                    .opacity(1 - headerVisibleRatio)

                AsyncImage(
                    url: URL(string: "https://upload.wikimedia.org/wikipedia/en/8/8f/AnthraxWCFYA.jpg"),
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
                .opacity(headerVisibleRatio)
                .padding(.top, 60)
                .padding(.horizontal, 20)
            }
        }
        .frame(height: Self.height)
    }
}

@available(iOS 15.0, *)
private extension SpotifyPreviewHeader {

    var isScrolled: Bool {
        headerVisibleRatio < 1
    }

    var rotationDegrees: CGFloat {
        if isScrolled { return 0 }
        let value = 20.0 * (1 - headerVisibleRatio)
        return value.capped(to: -5...0)
    }

    var verticalOffset: CGFloat {
        guard isScrolled else { return 0 }
        return 70.0 * (1 - headerVisibleRatio)
    }
}

private extension CGFloat {

    func capped(to range: ClosedRange<Self>) -> Self {
        if self < range.lowerBound { return range.lowerBound }
        if self > range.upperBound { return range.upperBound }
        return self
    }
}

private extension Color {

    static var viewPurple: Color {
        .init(red: 0.5, green: 0.4, blue: 0.5)
    }
}
