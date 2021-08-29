import Foundation
import SwiftUI
import Combine

/// The NavigationCoordinatable is used to represent a flow. If you want to push items to the stack you need to wrap this in a NavigationViewCoordinator.
public protocol NavigationCoordinatable: Coordinatable, NavigationResolver {
    associatedtype Start: View
    @ViewBuilder func start() -> Start
    var navigationStack: NavigationStack<Route> { get }
}

public extension NavigationCoordinatable {
    var dismissalAction: DismissalAction {
        get {
            navigationStack.dismissalAction
        } set {
            navigationStack.dismissalAction = newValue
        }
    }
    
    var childCoordinators: [AnyCoordinatable] {
        navigationStack.childCoordinators
    }
}

public extension NavigationCoordinatable {    
    func coordinatorView() -> AnyView {
        return AnyView(
            NavigationCoordinatableView(
                id: -1,
                coordinator: self
            )
        )
    }
    
    func dismissChildCoordinator(_ childCoordinator: AnyCoordinatable, _ completion: (() -> Void)?) {
        self.navigationStack.popTo(childCoordinator)
    }
}
