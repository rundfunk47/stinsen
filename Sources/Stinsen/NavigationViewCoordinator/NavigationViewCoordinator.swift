import Foundation
import SwiftUI

/// The NavigationViewCoordinator is used to represent a coordinator with a NavigationView
public class NavigationViewCoordinator<T: Coordinatable>: Coordinatable {
    public let child: T

    public func view() -> AnyView {
        AnyView(
            NavigationViewCoordinatorView(coordinator: self)
        )
    }
    
    public init(_ childCoordinator: T) {
        self.child = childCoordinator
    }
}
