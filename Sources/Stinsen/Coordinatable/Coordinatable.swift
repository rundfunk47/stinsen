import Foundation
import SwiftUI

///A Coordinatable usually represents some kind of flow in the app. You do not need to implement this directly if you're not toying with other types of navigation e.g. a hamburger menu, but rather you would implement TabCoordinatable, NavigationCoordinatable or RootCoordinatable.
public protocol Coordinatable: ObservableObject, Identifiable {
    ///Returns a view for the coordinator
    func coordinatorView() -> AnyView
    var id: String { get }
    var children: Children { get }
    var isNavigationCoordinator: Bool { get }
}

public extension Coordinatable {
    var id: String {
        return ObjectIdentifier(self).debugDescription + String(describing: Self.self)
    }
}
