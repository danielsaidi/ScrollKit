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
         }.frame(minHeight: 300)
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
            ZStack {
                if geo.frame(in: .global).minY <= 0 {
                    content()
                        .frame(
                            width: geo.size.width,
                            height: geo.size.height
                        )
                        .offset(y: -(geo.frame(in: .global).minY / 100))
                } else {
                    content()
                        .frame(
                            width: geo.size.width,
                            height: geo.size.height + geo.frame(in: .global).minY
                        )
                        .offset(y: -geo.frame(in: .global).minY)
                }
            }
        }
    }
}

@available(iOS 16.0, *)
struct ScrollViewHeader_Previews: PreviewProvider {

    struct PreviewHeader: View {

        var body: some View {
            ScrollViewHeader {
                ZStack(alignment: .bottomLeading) {
                    ScrollViewHeaderGradient(.blue, .topLeading, .yellow, .bottom)
                    ScrollViewHeaderGradient()
                    headerTitle
                }
            }
            .colorScheme(.dark)
            .frame(minHeight: 300)
        }

        private var headerTitle: some View {
            VStack(alignment: .leading) {
                Text("Title").font(.title)
                Text("Subtitle").font(.headline)
            }
            .padding()
        }
    }

    static var previews: some View {
        NavigationView {
            ScrollView {
                PreviewHeader()
                LazyVStack {
                    ForEach(1...100, id: \.self) {
                        Text("\($0)").padding(5)
                        Divider()
                    }
                }
            }
        }
        .accentColor(.white)
    }
}
