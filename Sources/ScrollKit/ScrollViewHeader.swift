//
//  ScrollViewHeader.swift
//  ScrollKit
//
//  Created by Daniel Saidi on 2022-10-13.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view can be used as a scroll view header and stretches
 its content when pulled down.

 For instance, this creates a header with a background color
 gradient, a dark gradient overlay and a bottom-leading text:

 ```swift
 struct MyHeader: View {

     var body: some View {
         ScrollViewHeader {
             ZStack(alignment: .bottomLeading) {
                 LinearGradient(
                     colors: [.blue, .yellow],
                     startPoint: .topLeading,
                     endPoint: .bottomTrailing)
                 LinearGradient(
                     colors: [.clear, .black.opacity(0.6)],
                     startPoint: .top,
                     endPoint: .bottom)
                 Text("Header title")
                    .padding()
             }
         }.frame(height: 250)
     }
 }
 ```

 To add this title to a scroll view, with more content below
 the header, just add the header topmost in a `VStack`:

 ```swift
 ScrollView(.vertical) {
     VStack(spacing: 0) {
         MyHeader()
         // More content here
     }
 }
 ```

 The `MyHeader` view will now automatically stretch out when
 the scroll view is pulled down.
 */
public struct ScrollViewHeader<Content: View>: View {

    /// Create a stretchable scroll view header.
    public init(
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.content = content
    }

    private let content: () -> Content

    public var body: some View {
        GeometryReader { geo in
            content()
                .stretchable(in: geo)
        }
    }
}

private extension View {

    @ViewBuilder
    func stretchable(in geo: GeometryProxy) -> some View {
        let width = geo.size.width
        let height = geo.size.height
        let minY = geo.frame(in: .global).minY
        let useStandard = minY <= 0
        self.frame(width: width, height: height + (useStandard ? 0 : minY))
            .offset(y: useStandard ? 0 : -minY)
    }
}

#Preview {
    
    struct Preview: View {
        
        var body: some View {
            #if canImport(UIKit)
            NavigationView {
                content
            }
            .accentColor(.white)
            .colorScheme(.dark)
            #else
            content
                .accentColor(.white)
                .colorScheme(.dark)
            #endif
        }
        
        var content: some View {
            ScrollView {
                VStack {
                    ScrollViewHeader {
                        TabView {
                            Color.red
                            Color.green
                            Color.blue
                        }
                        #if canImport(UIKit)
                        .tabViewStyle(.page)
                        #endif
                    }
                    .frame(height: 250)
                    
                    LazyVStack {
                        ForEach(0...100, id: \.self) {
                            Text("\($0)")
                        }
                    }
                }
            }
            .navigationTitle("Test")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
        }
    }

    return Preview()
}
