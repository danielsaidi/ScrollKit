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
 out if the scroll view is pulled down.

 This makes it possible for this header to have a background
 image or color that will resize to fit any additional space
 that the header receives when it's pulled down.

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

 To add this title to a scroll view, with some content after
 the header, just add the header topmost:

 ```swift
 ScrollView(.vertical) {
     VStack(spacing: 0) {
         MyHeader()
         // More content here
     }
 }
 ```

 This will automatically make the header view stretch out if
 the scroll view is pulled down.
 */
public struct ScrollViewHeader<Content: View>: View {

    /**
     Create a stretchable scroll view header.
     */
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

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
struct ScrollViewHeader_Previews: PreviewProvider {

    static var previews: some View {
        NavigationView {
            ScrollView {
                ScrollViewHeader {
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
        .accentColor(.white)
        .colorScheme(.dark)
    }
}
