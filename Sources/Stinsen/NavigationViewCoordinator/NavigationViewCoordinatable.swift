import Foundation
import SwiftUI

/// The NavigationViewCoordinatable is used to represent a coordinator with a NavigationView
public class NavigationViewCoordinatable: Coordinatable {
    public var dismissalAction: DismissalAction {
        get {
            children.dismissalAction
        } set {
            children.dismissalAction = newValue
        }
    }
    
    public func dismissChildCoordinator(_ childCoordinator: AnyCoordinatable, _ completion: (() -> Void)?) {
        children.childCoordinator = nil
    }
    
    public var childCoordinators: [AnyCoordinatable] {
        [children.childCoordinator].compactMap { $0 }
    }
    
    @ObservedObject public var children: NavigationViewChild

    public func coordinatorView() -> AnyView {
        AnyView(
            NavigationViewCoordinatableView(coordinator: self)
        )
    }
        
    public init<T: Coordinatable>(_ childCoordinator: T) {
        self.children = NavigationViewChild(childCoordinator.eraseToAnyCoordinatable())
    }
}
