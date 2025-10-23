//
//  ScrollViewOffsetTracker.swift
//  ScrollKit
//
//  Created by Daniel Saidi on 2023-12-04.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This view can be used as to the content view of a `ScrollView` or a `List`
/// to be able to get the scroll offset as the view is scrolled.
///
/// To use this view, just add it as the main content view in a `ScrollView` or a
/// `List`, then apply ``SwiftUI/View/scrollViewOffsetTracking(action:)``
/// to the parent view, like this:
///
/// ```swift
/// List {
///     ScrollViewOffsetTracker {
///         ForEach(0...100, id: \.self) {
///             Text("\($0)")
///                 .frame(width: 200, height: 200)
///         }
///     }
/// }
/// .scrollViewOffsetTracking { offset in
///     print(offset)
/// }
/// ```
///
/// The offset action will be called with the scroll offset whenever the view scrolls.
public struct ScrollViewOffsetTracker<Content: View>: View {
    
    public init(
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.content = content
    }
    
    private var content: () -> Content

    public var body: some View {
        ZStack(alignment: .top) {
            GeometryReader { geo in
                Color.clear
                    .preference(
                        key: ScrollOffsetPreferenceKey.self,
                        value: geo.frame(in: .named(ScrollOffsetNamespace.namespace)).origin
                    )
            }
            .frame(height: 0)
            
            content()
        }
    }
}

public extension View {

    /// Add this modifier to a `ScrollView`, a `List` or any view that has a
    /// ``ScrollViewOffsetTracker`` to track its scroll offset.
    func scrollViewOffsetTracking(
        action: @escaping @MainActor @Sendable (_ offset: CGPoint) -> Void
    ) -> some View {
        self.coordinateSpace(name: ScrollOffsetNamespace.namespace)
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { offset in
                DispatchQueue.main.async {
                    action(offset)
                }
            }
    }
}


enum ScrollOffsetNamespace {

    static let namespace = "scrollView"
}

struct ScrollOffsetPreferenceKey: PreferenceKey {

    static var defaultValue: CGPoint { .zero }

    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {}
}

#Preview {
    
    struct Preview: View {
        
        @State
        private var offset = CGPoint.zero
        
        var body: some View {
            ScrollView(.vertical) {
                ScrollViewOffsetTracker {
                    VStack {
                        ForEach(0...100, id: \.self) {
                            Text("\($0)")
                                .frame(width: 200, height: 200)
                                .background(Color.red)
                        }
                    }
                }
            }
            .scrollViewOffsetTracking { offset in
                let roundedX = offset.x.rounded()
                let roundedY = offset.y.rounded()
                self.offset = .init(x: roundedX, y: roundedY)
            }
            .navigationTitle("\(offset.debugDescription)")
        }
    }
    
    return NavigationView {
        #if os(macOS)
        Color.clear
        #endif
        Preview()
    }
}
