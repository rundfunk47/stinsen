import Foundation
import SwiftUI

/// A Coordinatable usually represents some kind of flow in the app. You do not need to implement this directly if you're not toying with other types of navigation e.g. a hamburger menu, but rather you would implement TabCoordinatable, NavigationCoordinatable or ViewCoordinatable.
public protocol Coordinatable: ObservableObject, Identifiable, AnyCoordinatable {

}

public protocol AnyCoordinatable: Presentable, AnyObject {
    /// This function is used internally for Stinsen. Do not implement this directly in a coordinator, it will use the a standard implementation derived from the coordinatable you're implementing. The ID for the coordinator. Will not be unique across instances of the coordinator.
    var id: String { get }
    var parent: AnyCoordinatable? { get set }
    func dismissChild(coordinator: AnyCoordinatable, action: (() -> Void)?)
}

public extension Coordinatable {
    var id: String {
        return ObjectIdentifier(self).debugDescription + NSStringFromClass(Self.self) //objc-name for better debugging
    }
}
