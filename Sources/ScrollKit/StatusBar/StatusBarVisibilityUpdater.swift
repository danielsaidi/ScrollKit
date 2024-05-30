#if os(iOS) || os(visionOS)
//
//  StatusBarVisibilityUpdater.swift
//  ScrollKit
//
//  Created by Daniel Saidi on 2023-03-14.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This view modifier can be used to automatically keep any
/// injected ``StatusBarVisibleState`` instances  updated as
/// the user scrolls.
///
/// For now, the easiest way to apply this view modifier, is
/// with ``SwiftUI/View/hideStatusBarUntilScrolled(using:)``.
public struct StatusBarVisibilityUpdater: ViewModifier {

    public init(scrollOffset: Binding<CGPoint>) {
        _offset = scrollOffset
    }

    @Binding
    private var offset: CGPoint

    @Environment(\.presentationMode)
    private var presentationMode

    @EnvironmentObject
    private var state: StatusBarVisibleState

    public func body(content: Content) -> some View {
        content
            .onAppear {
                state.hideUntilScrolled(using: offset)
            }
            #if os(iOS)
            .onChange(of: offset) {
                state.hideUntilScrolled(using: $0)
            }
            .onChange(of: presentationMode.wrappedValue.isPresented) { _ in
                offset.y = 0
                state.isHidden = false
            }
            #else
            .onChange(of: offset) {
                state.hideUntilScrolled(using: $1)
            }
            .onChange(of: presentationMode.wrappedValue.isPresented) { _, _ in
                offset.y = 0
                state.isHidden = false
            }
            #endif
    }
}

@MainActor
public extension View {

    /// Automatically keep ``StatusBarVisibleState`` updated
    /// so it hides the status bar until the provided offset 
    /// is indicating that a view has been scrolled.
    func hideStatusBarUntilScrolled(using offset: Binding<CGPoint>) -> some View {
        self.modifier(StatusBarVisibilityUpdater(scrollOffset: offset))
    }
}
#endif
