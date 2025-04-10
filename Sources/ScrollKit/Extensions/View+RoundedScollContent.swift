//
//  View+RoundedScollContent.swift
//  ScrollKit
//
//  Created by Daniel Saidi on 2025-04-09.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {
    
    /// Make a scroll view's content view overlap the scroll
    /// header, by applying a negative offset.
    ///
    /// Do not use this together with a sticky header, since
    /// a sticky header will overlap the content, which will
    /// ruin this overlap effect.
    ///
    /// - Parameters:
    ///   - points: The number of points to overlap, by default `10`.
    func scrollViewContentWithHeaderOverlap(
        _ points: Double? = nil
    ) -> some View {
        self.offset(y: -(points ?? 10))
    }
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
public extension View {
    
    /// Make a scroll view's content view overlap the scroll
    /// header with rounded corners.
    ///
    /// Do not use this together with a sticky header, since
    /// a sticky header will overlap the content, which will
    /// ruin this overlap effect.
    ///
    /// - Parameters:
    ///   - points: The number of points to overlap, by default `10`.
    ///   - radius: The top corner radius, by default `8`.
    func scrollViewContentWithRoundedHeaderOverlap(
        _ overlap: Double? = nil,
        cornerRadius radius: CGFloat = 8
    ) -> some View {
        self.background(.background)
            .clipShape(UnevenRoundedRectangle(topLeadingRadius: radius, topTrailingRadius: radius))
            .frame(maxHeight: .infinity)
            .scrollViewContentWithHeaderOverlap(overlap)
    }
        
    /// Make a scroll view header view apply rounded corners
    /// that cut out a mask for the scroll view content view.
    ///
    /// - Parameters:
    ///   - cornerRadius: The number of points to overlap, by default `0`.
    @ViewBuilder
    func scrollViewHeaderWithRoundedContentCorners(
        cornerRadius: Double = 0
    ) -> some View {
        if cornerRadius > 0 {
            self.mask {
                VStack(spacing: 0) {
                    /// Make the black color overflow waaaay up.
                    Color.black.scaleEffect(100, anchor: .bottom)
                    ZStack {
                        Color.white
                        UnevenRoundedRectangle(
                            topLeadingRadius: cornerRadius,
                            topTrailingRadius: cornerRadius
                        )
                        .fill(.black)
                    }
                    .compositingGroup()
                    .luminanceToAlpha()
                    .frame(height: cornerRadius)
                }
            }
        } else {
            self
        }
    }
}

#Preview {
    
    ScrollViewWithStickyHeader(
        .vertical,
        header: { Color.red },
        headerHeight: 250,
        headerMinHeight: 150,
        contentCornerRadius: 20,
        showsIndicators: false,
    ) {
        LazyVStack {
            ForEach(1...100, id: \.self) {
                Text("\($0)")
            }
        }
    }
}
