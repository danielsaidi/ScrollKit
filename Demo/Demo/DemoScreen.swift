//
//  DemoScreen.swift
//  ScrollKit
//
//  Created by Daniel Saidi on 2023-02-04.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import ScrollKit
import SwiftUI

/**
 This view takes a custom header view and height and adds it
 to a scroll view with sticky header.
 */
struct DemoScreen<Content: View>: View {

    @Binding
    var isStatusBarHidden: Bool

    let headerHeight: CGFloat

    @ViewBuilder
    let headerView: () -> Content

    @State
    private var headerVisibleRatio: CGFloat = 1

    var body: some View {
        ScrollViewWithStickyHeader(
            header: header,
            headerHeight: headerHeight,
            onScroll: handleScrollOffset
        ) {
            listItems
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Demo Title")
                    .font(.headline)
                    .previewHeaderContent()
                    .opacity(1 - headerVisibleRatio)
            }
        }
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbarBackground(.hidden)
        .background(Color.black.opacity(0.1))
    }

    func header() -> some View {
        ZStack(alignment: .bottomLeading) {
            headerView()
            ScrollViewHeaderGradient()
            headerTitle.previewHeaderContent()
        }
    }

    var headerTitle: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Demo Title").font(.largeTitle)
            Text("Some additional information")
        }
        .padding(20)
        .opacity(headerVisibleRatio)
    }

    var listItems: some View {
        VStack {
            ForEach(1...100, id: \.self) {
                Text("Item \($0)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Divider()
            }
        }
        .padding()
        .background(Material.regular)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.1), radius: 5)
        .padding()
    }

    func handleScrollOffset(_ offset: CGPoint, headerVisibleRatio: CGFloat) {
        self.isStatusBarHidden = offset.y >= -2
        self.headerVisibleRatio = headerVisibleRatio
    }
}

struct DemoScreen_Previews: PreviewProvider {

    static func header() -> some View {
        ScrollViewHeaderImage(Image("header"))
    }

    static var previews: some View {
        NavigationView {
            DemoScreen(
                isStatusBarHidden: .constant(true),
                headerHeight: 250,
                headerView: header
            )
        }
    }
}

private extension View {

    func previewHeaderContent() -> some View {
        self.foregroundColor(.white)
            .shadow(color: .black.opacity(0.4), radius: 1, x: 1, y: 1)
    }
}
