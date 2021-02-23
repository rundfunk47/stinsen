import Foundation
import SwiftUI
import Combine

/// The NavigationCoordinatable is used to represent a flow. If you want to push items to the stack you need to wrap this in a NavigationViewCoordinatable.
public protocol NavigationCoordinatable: Coordinatable {
    associatedtype Route
    associatedtype Start: View
    func resolveRoute(route: Route) -> Transition
    @ViewBuilder func start() -> Start
    var navigationStack: NavigationStack<Route> { get }
}

public extension NavigationCoordinatable {
    var isNavigationCoordinator: Bool {
        return true
    }
}

public extension NavigationCoordinatable {
    func route(to route: Route) {
        let resolved = resolveRoute(route: route)
        switch resolved {
        case .push(let resolved):
            if resolved is AnyView {
                self.navigationStack.value.append(.push(route))
            } else if let resolved = resolved as? AnyCoordinatable {
                self.children.activeChildCoordinator = resolved
            } else {
                fatalError("Unsupported presentable")
            }
        case .modal(let resolved):
            if resolved is AnyView {
                self.navigationStack.value.append(.modal(route))
            } else if let resolved = resolved as? AnyCoordinatable {
                self.children.activeModalChildCoordinator = resolved
            } else {
                fatalError("Unsupported presentable")
            }
        }
    }
    
    func coordinatorView() -> AnyView {
        return AnyView(
            NavigationCoordinatableView(
                id: nil,
                coordinator: self
            )
        )
    }
}
