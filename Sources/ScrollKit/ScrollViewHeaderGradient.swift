//
//  ScrollViewHeader.swift
//  ScrollKit
//
//  Created by Daniel Saidi on 2023-02-04.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view can be used as a scroll view header overlay, when
 the background may cause the content to be hard to overview.

 This is basically just a convenience to avoid having to use
 a `LinearGradient` and define its colors, anchor points etc.
 */
public struct ScrollViewHeaderGradient: View {

    /**
     Create a scroll view header gradient.

     - Parameters:
       - startColor: The top start color, by default `.clear`.
       - startPoint: The top start point, by default `.top`.
       - endColor: The bottom end color, by default `.black` with `0.3` opacity.
       - endPoint: The top start point, by default `.bottom`.
     */
    public init(
        _ startColor: Color = .clear,
        _ startPoint: UnitPoint = .top,
        _ endColor: Color = .black.opacity(0.3),
        _ endPoint: UnitPoint = .bottom
    ) {
        self.startColor = startColor
        self.startPoint = startPoint
        self.endColor = endColor
        self.endPoint = endPoint
    }

    private let startColor: Color
    private let startPoint: UnitPoint
    private let endColor: Color
    private let endPoint: UnitPoint

    public var body: some View {
        LinearGradient(
            colors: [startColor, endColor],
            startPoint: startPoint,
            endPoint: endPoint)
    }
}

struct ScrollViewHeaderGradient_Previews: PreviewProvider {

    static var previews: some View {
        VStack {
            ScrollViewHeaderGradient()
            ScrollViewHeaderGradient(.blue, .topLeading, .yellow, .bottom)
        }
    }
}
