//
//  SpotifyPreviewScreenHeader.swift
//  ScrollKit
//
//  Created by Daniel Saidi on 2023-02-06.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI
/**
 This view mimics the Spotify release screen header.
 */
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public struct SpotifyPreviewScreenHeader: View {

    public init(
        info: SpotifyPreviewInfo,
        headerVisibleRatio: CGFloat = 1
    ) {
        self.info = info
        self.headerVisibleRatio = headerVisibleRatio
    }

    public static var height: CGFloat = 280

    private var info: SpotifyPreviewInfo
    private var headerVisibleRatio: CGFloat

    public var body: some View {
        ZStack {
            ScrollViewHeaderGradient(info.tintColor, .black)
            ScrollViewHeaderGradient(info.tintColor.opacity(1), info.tintColor.opacity(0))
                .opacity(1 - headerVisibleRatio)
            cover
        }
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
private extension SpotifyPreviewScreenHeader {

    var cover: some View {
        AsyncImage(
            url: URL(string: info.releaseCoverUrl),
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
        .padding(.bottom, 20)
        .padding(.horizontal, 20)
    }

    var rotationDegrees: CGFloat {
        guard headerVisibleRatio > 1 else { return 0 }
        let value = 20.0 * (1 - headerVisibleRatio)
        return value.capped(to: -5...0)
    }

    var verticalOffset: CGFloat {
        guard headerVisibleRatio < 1 else { return 0 }
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

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
struct SpotifyPreviewScreenHeader_Previews: PreviewProvider {

    static var previews: some View {
        SpotifyPreviewScreenHeader(info: .anthrax)
            .frame(height: SpotifyPreviewScreenHeader.height)
    }
}
