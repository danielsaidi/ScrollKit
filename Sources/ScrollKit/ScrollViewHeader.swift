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

@available(iOS 15.0, *)
struct ScrollViewHeader_Previews: PreviewProvider {

    static var header: some View {
        ScrollViewHeader {
            ZStack {
                LinearGradient(
                    colors: [.init(red: 0.5, green: 0.4, blue: 0.5), .black],
                    startPoint: .top,
                    endPoint: .bottom
                )
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
                .padding(.top, 60)
                .padding(.horizontal, 20)
            }
        }
        .frame(height: 280)
    }

    static var content: some View {
        VStack(spacing: 20) {
            title
            buttons
            list
        }
        .padding()
    }

    static var title: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("We've Come for You All")
                .font(.title2.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Anthrax")
                .font(.footnote.bold())
            Text("Album · 2003")
                .font(.footnote.bold())
                .foregroundColor(.secondary)
        }
    }

    static var buttons: some View {
        HStack(spacing: 15) {
            Image(systemName: "heart")
            Image(systemName: "arrow.down.circle")
            Image(systemName: "ellipsis")
            Spacer()
            Image(systemName: "shuffle")
            Image(systemName: "play.circle.fill")
                .font(.largeTitle)
                .foregroundColor(.green)
        }
        .font(.title3)
        .navigationBarTitleDisplayMode(.large)
    }

    static var list: some View {
        LazyVStack(alignment: .leading, spacing: 30) {
            listItem("Contact")
            listItem("What Doesn't Die")
            listItem("Superhero")
            listItem("Refuse to Be Denied")
            listItem("Safe Home")
            listItem("Any Place But Here")
            listItem("Nobody Knows Anything")
        }
    }

    static func listItem(_ song: String) -> some View {
        VStack(alignment: .leading) {
            Text(song).font(.headline)
            Text("Anthrax")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
    }

    static var previews: some View {
        NavigationView {
            ScrollView {
                header
                content
            }
        }
        .accentColor(.white)
        .colorScheme(.dark)
    }
}
