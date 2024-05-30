//
//  ScrollViewOffsetTracker.swift
//  ScrollKit
//
//  Created by Daniel Saidi on 2023-12-04.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This view can wrap any `ScrollView` or `List` content to
/// get offset tracking working when the view is scrolled.
///
/// To use this view, add it to a `ScrollView` or `List` and
/// add a content view to it, then simply apply the modifier
/// ``SwiftUI/View/withScrollOffsetTracking(action:)``, just
/// like this:
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
/// .withScrollOffsetTracking {
///     offset in print(offset)
///     }
/// ```
///
/// The offset action will trigger when the list scrolls and
/// provide you with the scroll offset.
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

    /// Add this modifier to a `ScrollView`, a `List` or any
    /// view that has a ``ScrollViewOffsetTracker`` to track
    /// its scroll offset.
    func withScrollOffsetTracking(
        action: @escaping (_ offset: CGPoint) -> Void
    ) -> some View {
        self.coordinateSpace(name: ScrollOffsetNamespace.namespace)
            .onPreferenceChange(ScrollOffsetPreferenceKey.self, perform: action)
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
            .withScrollOffsetTracking(action: { offset = .init(x: $0.x.rounded(), y: $0.y.rounded()) })
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
