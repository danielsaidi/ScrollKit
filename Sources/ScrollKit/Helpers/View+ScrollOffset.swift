//
//  View+ScrollOffset.swift
//  ScrollKit
//
//  Created by Daniel Saidi on 2023-12-04.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

extension View {

    /**
     Add this modifier to any `ScrollView`, `List` or custom
     view that uses ``ScrollViewOffsetTracker`` to track its
     scroll offset.
     */
    func withScrollOffsetTracking(
        action: @escaping (_ offset: CGPoint) -> Void
    ) -> some View {
        self.coordinateSpace(name: ScrollOffsetNamespace.namespace)
            .onPreferenceChange(ScrollOffsetPreferenceKey.self, perform: action)
    }
}
