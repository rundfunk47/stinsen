import Foundation
import SwiftUI

/// A presentable is something that can presented as a view. It can either be a view (AnyView) or a coordinator (Coordinatable)
public protocol Presentable {
    /// This function is used internally for Stinsen. Do not implement this directly in a coordinator, it will use the a standard implementation derived from the coordinatable you're implementing. Returns a view for the presentable.
    func view() -> AnyView
}

extension AnyView: Presentable {
    public func view() -> AnyView {
        return self
    }
}
