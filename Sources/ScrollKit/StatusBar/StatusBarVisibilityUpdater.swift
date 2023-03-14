#if os(iOS)
//
//  StatusBarVisibilityUpdater.swift
//  ScrollKit
//
//  Created by Daniel Saidi on 2023-03-14.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This modifier can be used to automatically keep an injected
 ``StatusBarVisibileState`` up to date as a view scrolls.

 For now, the easiest way to apply this modifier is by using
 the `.hideStatusBarUntilScrolled(_)` view modifier.

 If this modifier needs to be extended in the future, we can
 add an enum to set how the ``StatusBarVisibileState`` is to
 be updated for a certain scroll offset, but for now it only
 hides the status bar until the offset indicates that a view
 has been scrolled.
 */
public struct StatusBarVisibilityUpdater: ViewModifier {

    public init(scrollOffset: Binding<CGPoint>) {
        _offset = scrollOffset
    }

    @Binding
    private var offset: CGPoint

    @Environment(\.presentationMode)
    private var presentationMode

    @EnvironmentObject
    private var state: StatusBarVisibileState

    public func body(content: Content) -> some View {
        content
            .onAppear {
                state.hideUntilScrolled(using: offset)
            }
            .onChange(of: offset) {
                state.hideUntilScrolled(using: $0)
            }
            .onChange(of: presentationMode.wrappedValue.isPresented) { _ in
                offset.y = 0
                state.isHidden = false
            }
    }
}

public extension View {

    /**
     Automatically keep a ``StatusBarVisibileState`` updated
     so it hides the status bar until the provided offset is
     indicating that a view has been scrolled.
     */
    func hideStatusBarUntilScrolled(using offset: Binding<CGPoint>) -> some View {
        self.modifier(StatusBarVisibilityUpdater(scrollOffset: offset))
    }
}
#endif
