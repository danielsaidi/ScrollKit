//
//  ScrollViewOffsetTracker.swift
//  ScrollKit
//
//  Created by Gabriel Ribeiro on 2025-04-06.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

final class ScrollManager: ObservableObject {
    private var proxy: ScrollViewProxy?

    func setProxy(_ proxy: ScrollViewProxy) {
        self.proxy = proxy
    }

    func scrollToHeader(anchor: UnitPoint = .top) {
        proxy?.scrollTo(ScrollTargets.header, anchor: anchor)
    }

    func scrollToContent(anchor: UnitPoint = .top) {
        proxy?.scrollTo(ScrollTargets.content, anchor: anchor)
    }
}

enum ScrollTargets {
    static let header = "scrollkit-header"
    static let content = "scrollkit-content"
}