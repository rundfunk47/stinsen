import Foundation
import SwiftUI
import Combine

/// The NavigationCoordinatable is used to represent a flow. If you want to push items to the stack you need to wrap this in a NavigationViewCoordinatable.
public protocol NavigationCoordinatable: Coordinatable {
    associatedtype Route
    associatedtype Start: View
    func resolveRoute(route: Route) -> Transition
    @ViewBuilder func start() -> Start
    var navigationStack: NavigationStack { get }
}

public extension NavigationCoordinatable {
    var childDismissalAction: DismissalAction {
        get {
            navigationStack.childDismissalAction
        } set {
            navigationStack.childDismissalAction = newValue
        }
    }
    
    var appearingMetadata: AppearingMetadata? {
        self.navigationStack
    }
    
    var childCoordinators: [AnyCoordinatable] {
        navigationStack.childCoordinators
    }
}

public extension NavigationCoordinatable {
    func route(to route: Route) {
        let resolved = resolveRoute(route: route)
        self.navigationStack.append(resolved)
    }
    
    func coordinatorView() -> AnyView {
        return AnyView(
            NavigationCoordinatableView(
                id: -1,
                coordinator: self
            )
        )
    }
    
    func dismissChildCoordinator(_ childCoordinator: AnyCoordinatable, _ completion: (() -> Void)?) {
        
        let oldAction = self.childDismissalAction
        self.childDismissalAction = {
            oldAction()
            completion?()
        }

        self.navigationStack.popTo(childCoordinator)
    }
}
