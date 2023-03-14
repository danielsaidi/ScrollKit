#if os(iOS)
//
//  StatusBarVisibileState.swift
//  ScrollKit
//
//  Created by Daniel Saidi on 2023-03-13.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This class can be used to manage the visibility of the main
 status bar across a view hierarchy.

 To use the class, just create a `@StateObject` and apply it
 to any view using the `.statusBarVisibile(_)` view modifier.
 This will apply `.statusBar(hidden:)` to the view using the
 ``isHidden`` property and inject the instance into the view
 hierarchy using an `.environmentObject(_)` view modifier.

 You can now retrieve the instance in any screen or view and
 set ``isHidden`` to show and hide the status bar. There are
 convenience functions to handle calculations and animations,
 such as ``hide(if:ifGreaterThan:)``, which can be used when
 the status bar should become visible after scrolling down a
 bit, which is a way to mitigate the bad default behavior in
 iOS, where `.toolbarColorScheme(_:for:)` only applies after
 scrolling down to fade in the navigation bar.

 Note that when you are using this state class together with
 a `NavigationStack`, you must apply it to the stack itself:

 ```swift
 struct ContentView: View {

     @StateObject
     private var state = StatusBarVisibileState()

     var body: some View {
         NavigationStack {
             ...
         }
         .statusBarVisible(state)
     }
 }
 ```

 Take a look at the demo app for examples of how this can be
 used to hide the status bar until the screen is scrolled.
 */
public class StatusBarVisibileState: ObservableObject {

    /**
     Create a visibility state instance.

     - Parameters:
       - isHidden: Whether or not to initially hide the status bar, by default `false`.
       - isAnimated: Whether or not to animate changes, by default `false`.
     */
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

public extension StatusBarVisibileState {

    /**
     Update ``isHidden`` to become true when an offset's `y`
     value is greater than a certain value.

     - Parameters:
       - offset: The offset to use.
       - value: An optional value that controls when the status bar should be hidden.
     */
    func hide(if offset: CGPoint, ifGreaterThan value: CGFloat) {
        updateIsHidden(with: offset.y > value)
    }

    /**
     Update ``isHidden`` to become true when an offset's `y`
     value is greater than a certain value.

     - Parameters:
       - offset: The offset to use.
       - value: An optional value that controls when the status bar should be hidden.
     */
    func hide(if offset: CGPoint, ifLessThan value: CGFloat) {
        updateIsHidden(with: offset.y < value)
    }

    /**
     Update ``isHidden`` to become true when an offset's `y`
     value indicates that a view is pulled down.

     Note however that this will not look good when a status
     bar should use light content, since light content isn't
     applied if the navigation bar isn't showing.

     - Parameters:
       - offset: The offset to use.
     */
    func hideUntilPulled(using offset: CGPoint) {
        hide(if: offset, ifLessThan: 2)
    }

    /**
     Update ``isHidden`` to become true when an offset's `y`
     value indicates that a view is scrolled.

     - Parameters:
       - offset: The offset to use.
     */
    func hideUntilScrolled(using offset: CGPoint) {
        hide(if: offset, ifGreaterThan: -3)
    }
}

private extension StatusBarVisibileState {

    func updateIsHidden(with value: Bool) {
        if isAnimated {
            withAnimation { isHidden = value }
        } else {
            isHidden = value
        }
    }
}

public extension View {

    func statusBarVisible(_ state: StatusBarVisibileState) -> some View {
        self.statusBarHidden(state.isHidden)
            .environmentObject(state)
    }
}
#endif
