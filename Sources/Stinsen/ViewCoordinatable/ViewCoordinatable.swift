import Foundation
import SwiftUI

///The ViewCoordinatable represents a view with routes that can be switched to but not pushed or presented modally. This can be used if you have a need to switch between different "modes" in the app, for instance if you switch between logged in and logged out. The ViewCoordinatable will recreate the view and the coordinator, so it is not suited to replace a tab-bar or similar modes of navigation, where you want to preserve the state.
public protocol ViewCoordinatable: Coordinatable {
    associatedtype Route: ViewRoute
    associatedtype CustomizeViewType: View
    associatedtype Start: View
    func resolveRoute(route: Route) -> AnyCoordinatable
    @ViewBuilder func start() -> Start
    var children: ViewChild { get }
    func customize(_ view: AnyView) -> CustomizeViewType
}

public extension ViewCoordinatable {
    var childCoordinators: [AnyCoordinatable] {
        return [children.childCoordinator].compactMap { $0 }
    }
    
    var dismissalAction: DismissalAction {
        get {
            children.dismissalAction
        } set {
            children.dismissalAction = newValue
        }
    }
        
    func coordinatorView() -> AnyView {
        return AnyView(
            ViewCoordinatableView(coordinator: self, customize: customize)
        )
    }
    
    func customize(_ view: AnyView) -> some View {
        return view
    }
    
    func dismissChildCoordinator(_ childCoordinator: AnyCoordinatable, _ completion: (() -> Void)?) {
        fatalError("not implemented")
    }
}
