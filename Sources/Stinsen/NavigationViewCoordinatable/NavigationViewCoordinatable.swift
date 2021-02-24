import Foundation
import SwiftUI

/// The NavigationViewCoordinatable is used to represent a coordinator with a NavigationView
public class NavigationViewCoordinatable: Coordinatable {
    public var appearingMetadata: AppearingMetadata? = nil
    public var children = Children()

    public func coordinatorView() -> AnyView {
        AnyView(
            NavigationViewCoordinatableView(coordinator: self)
        )
    }
        
    public init<T: Coordinatable>(childCoordinator: T) {
        self.children.activeChildCoordinator = AnyCoordinatable(childCoordinator)
    }
}
