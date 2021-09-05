import Foundation
import SwiftUI

/// The TabCoordinatable is used to represent a coordinator with a TabView
public protocol TabCoordinatable: Coordinatable {
    associatedtype Route
    associatedtype ViewType: View
    associatedtype CustomizeViewType: View
    func resolveRoute(route: Route) -> AnyCoordinatable
    @ViewBuilder func tabItem(forRoute route: Route) -> ViewType
    /**
     Implement this function if you wish to customize the view on all views and child coordinators, for instance, if you wish to change the `tintColor` or inject an `EnvironmentObject`.

     - Parameter view: The input view.

     - Returns: The modified view.
     */
    func customize(_ view: AnyView) -> CustomizeViewType
    var children: TabChild<Self> { get }
}

public extension TabCoordinatable {
    var dismissalAction: DismissalAction {
        get {
            children.dismissalAction
        } set {
            children.dismissalAction = newValue
        }
    }
    
    var childCoordinators: [AnyCoordinatable] {
        [children.childCoordinator]
    }

    func coordinatorView() -> AnyView {
        AnyView(
            TabCoordinatableView(coordinator: self, customize: customize)
        )
    }
    
    func customize(_ view: AnyView) -> some View {
        return view
    }
    
    func dismissChildCoordinator(_ childCoordinator: AnyCoordinatable, _ completion: (() -> Void)?) {
        fatalError("not implemented")
    }
}

public extension TabCoordinatable where Route: Equatable {
    func handleDeepLink(_ deepLink: [Any]) throws {
        guard let first = deepLink.first else { return }
        guard let route = first as? Route else {
            throw DeepLinkError.unhandledDeepLink(deepLink: deepLink)
        }
        
        if route != self.children.activeRoute {
            try self.children.focus(route)
        }
        
        try self.children.childCoordinator.handleDeepLink(Array(deepLink.dropFirst()))
    }
}
