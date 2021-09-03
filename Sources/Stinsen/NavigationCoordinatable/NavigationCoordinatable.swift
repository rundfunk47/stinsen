import Foundation
import SwiftUI
import Combine

/// The NavigationCoordinatable is used to represent a flow. If you want to push items to the stack you need to wrap this in a NavigationViewCoordinator.
public protocol NavigationCoordinatable: Coordinatable {
    associatedtype Route
    associatedtype Start: View
    @ViewBuilder func start() -> Start
    var navigationStack: NavigationStack<Self> { get }
    func resolveRoute(route: Route) -> Transition
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

extension NavigationCoordinatable where Route: Equatable {
    func handleDeepLink(_ deepLink: [Any], isView: Bool) throws {
        guard let first = deepLink.first else { return }
        guard let route = first as? Route else {
            throw DeepLinkError.unhandledDeepLink(deepLink: deepLink)
        }
        
        if !isView {
            self.navigationStack.popToRoot()
        }

        self.navigationStack.append(route)
        
        // we need to know if this route produced a coordinator or a view.
        // if it produces a coordinator, we'll assume all remaining routes should be handled there
        // if it produces a view, use this coordinator as starting point.
        
        if let coordinator = self.navigationStack.value.last!.transition.presentable as? AnyCoordinatable {
            try coordinator.handleDeepLink(Array(deepLink.dropFirst()))
        } else {
            try self.handleDeepLink(Array(deepLink.dropFirst()), isView: true)
        }
    }

    func handleDeepLink(_ deepLink: [Any]) throws {
        try self.handleDeepLink(deepLink, isView: false)
    }
}
