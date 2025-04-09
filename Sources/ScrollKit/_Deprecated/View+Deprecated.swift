#if os(iOS) || os(visionOS)
import SwiftUI

public extension View {
    
    @available(*, deprecated, renamed: "statusBarHiddenUntilScrolled(offset:)")
    func hideStatusBarUntilScrolled(
        using offset: Binding<CGPoint>
    ) -> some View {
        self.statusBarHiddenUntilScrolled(offset: offset)
    }
    
    @available(*, deprecated, renamed: "scrollViewOffsetTracking")
    func withScrollOffsetTracking(
        action: @escaping @MainActor @Sendable (_ offset: CGPoint) -> Void
    ) -> some View {
        self.scrollViewOffsetTracking(action: action)
    }
}
#endif
