//
//  Spotify+PreviewScreen.swift
//  ScrollKit
//
//  Created by Daniel Saidi on 2023-02-07.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Spotify {
    
    /// This view mimics a Spotify album screen.
    struct PreviewScreen: View {
        
        public init(info: PreviewInfo) {
            self.info = info
        }
        
        private var info: PreviewInfo
        
        @Environment(\.dismiss)
        private var dismiss
        
        @State
        private var headerVisibleRatio = 1.0
        
        @State
        private var scrollOffset = CGPoint.zero
        
        public var body: some View {
            ScrollViewWithStickyHeader(
                header: scrollViewHeader,
                headerHeight: Spotify.PreviewScreenHeader.height,
                onScroll: handleScrollOffset
            ) {
                Spotify.PreviewScreenContent(info: info)
            }
            .preferredColorScheme(.dark)
            #if os(iOS)
            .hideBackButtonText()
            #endif
            #if os(iOS) || os(macOS) || os(tvOS)
            .toolbarTitle(toolbarTitleView)
            #endif
        }
        
        func scrollViewHeader() -> some View {
            Spotify.PreviewScreenHeader(
                info: info,
                headerVisibleRatio: headerVisibleRatio
            )
        }
        
        var toolbarTitleView: some View {
            Text(info.releaseTitle)
                .font(.headline.bold())
                .opacity(headerVisibleRatio > 0 ? 0 : -5 * headerVisibleRatio)
        }
        
        func handleScrollOffset(_ offset: CGPoint, headerVisibleRatio: CGFloat) {
            self.scrollOffset = offset
            self.headerVisibleRatio = headerVisibleRatio
        }
    }
}

private extension View {

    #if os(iOS)
    func hideBackButtonText() -> some View {
        self.toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Text("       ") // Hides the back button text :D
            }
        }
    }
    #endif

    func toolbarTitle<Title: View>(_ view: Title) -> some View {
        #if os(iOS) || os(macOS) || os(tvOS)
        self.toolbar {
            ToolbarItem(placement: .principal) {
                view
            }
        }
        #else
        self
        #endif
    }
}

#Preview("Navigation") {

    NavigationView {
        #if os(macOS)
        Color.clear
        #endif
        NavigationLink("Test") {
            Spotify.PreviewScreen(info: .regina)
        }
    }
    #if os(iOS)
    .navigationViewStyle(.stack)
    #endif
}

#if os(iOS)
#Preview("Sheet") {
    
    struct Preview: View {
        
        @State var isPresented = false
        
        var body: some View {
            Button("Present") {
                isPresented.toggle()
            }
            .sheet(isPresented: $isPresented) {
                NavigationView {
                    Spotify.PreviewScreen(info: .regina)
                }
                .navigationViewStyle(.stack)
            }
        }
    }
    
    return Preview()
}
#endif

