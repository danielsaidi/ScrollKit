#if os(iOS) || os(visionOS)
//
//  StatusBarVisibleState.swift
//  ScrollKit
//
//  Created by Daniel Saidi on 2023-03-13.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This class can be used to manage the visibility state of
/// the main status bar across a view hierarchy.
///
/// To use this class, just create a `@StateObject` instance
/// and apply it to any view with the `.statusBarVisibile(_)`
/// view modifier. This will inject `.statusBar(hidden:)` on
/// the view using the ``isHidden`` property, and inject the
/// instance as an environment object. You can then retrieve
/// the instance in any view and set ``isHidden`` to show or
/// hide the status bar.
///
/// There are also convenience functions that let you handle
/// calculations & animations with greated control, like the
/// ``hide(if:ifGreaterThan:)`` which can be used to control
/// when the status bar should become visible after a scroll
/// event, which lets you mitigate the bad, default behavior
/// in iOS, where `.toolbarColorScheme(_:for:)` only applies
/// after scrolling down to fade in the navigation bar.
///
/// Note that using this state class with a `NavigationStack`
/// requires that you apply it to the stack itself:
///
/// ```swift
/// struct ContentView: View {
///
///     @StateObject
///     private var state = StatusBarVisibleState()
///
///     var body: some View {
///         NavigationStack {
///             ...
///         }
///         .statusBarVisible(state)
///     }
/// }
/// ```
///
/// Take a look at the demo app for examples of how this can
/// be used to hide the status bar until you scroll.
public class StatusBarVisibleState: ObservableObject {

    /// Create a visibility state instance.
    ///
    /// - Parameters:
    ///   - isHidden: Whether or not to initially hide the status bar, by default `false`.
    ///   - isAnimated: Whether or not to animate changes, by default `false`.
    public init(
        isHidden: Bool = false,
        isAnimated: Bool = false
    ) {
        self.isHidden = isHidden
        self.isAnimated = isAnimated
    }

    /// Whether or not to initially hide the status bar.
    @Published
    public var isHidden: Bool

    /// Whether or not to animate changes
    @Published
    public var isAnimated: Bool
}

public extension StatusBarVisibleState {

    /// Update ``isHidden`` to become true when an offset `y`
    /// value is greater than a certain value.
    ///
    /// - Parameters:
    ///   - offset: The offset to use.
    ///   - value: An optional value that controls when the status bar should be hidden.
    func hide(
        if offset: CGPoint,
        ifGreaterThan value: CGFloat
    ) {
        updateIsHidden(with: offset.y > value)
    }

    /// Update ``isHidden`` to become true when an offset `y`
    /// value is greater than a certain value.
    ///
    /// - Parameters:
    ///   - offset: The offset to use.
    ///   - value: An optional value that controls when the status bar should be hidden.
    func hide(if offset: CGPoint, ifLessThan value: CGFloat) {
        updateIsHidden(with: offset.y < value)
    }

    /// Update ``isHidden`` to become true when an offset `y`
    /// value indicates that a view is pulled down.
    ///
    /// Note that this won't look good if a status bar use a
    /// light content configuration, since the light content
    /// isn't applied if the navigation bar isn't showing.
    ///
    /// - Parameters:
    ///   - offset: The offset to use.
    func hideUntilPulled(using offset: CGPoint) {
        hide(if: offset, ifLessThan: 2)
    }

    /// Update ``isHidden`` to become true when an offset `y`
    /// value indicates that a view is scrolled.
    ///
    /// - Parameters:
    ///   - offset: The offset to use.
    func hideUntilScrolled(using offset: CGPoint) {
        hide(if: offset, ifGreaterThan: -3)
    }
}

private extension StatusBarVisibleState {

    func updateIsHidden(with value: Bool) {
        if isAnimated {
            withAnimation { isHidden = value }
        } else {
            isHidden = value
        }
    }
}

public extension View {

    func statusBarVisible(_ state: StatusBarVisibleState) -> some View {
        self.statusBarHidden(state.isHidden)
            .environmentObject(state)
    }
}
#endif
