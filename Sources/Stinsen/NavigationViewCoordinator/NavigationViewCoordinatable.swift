import Foundation
import SwiftUI

/// The NavigationViewCoordinatable is used to represent a coordinator with a NavigationView
public class NavigationViewCoordinatable: Coordinatable {
    public var childDismissalAction: DismissalAction {
        get {
            children.childDismissalAction
        } set {
            children.childDismissalAction = newValue
        }
    }
    
    public func dismissChildCoordinator(_ childCoordinator: AnyCoordinatable, _ completion: (() -> Void)?) {
        let oldDismissal = childDismissalAction
        
        childDismissalAction = {
            completion?()
            oldDismissal()
        }
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
