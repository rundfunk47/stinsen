import Foundation
import SwiftUI

/// The TabCoordinatable is used to represent a coordinator with a TabView
public protocol TabCoordinatable: Coordinatable {
    associatedtype ViewType: View
    associatedtype CustomizeViewType: View
    @ViewBuilder func tabItem(forTab tab: Int) -> ViewType
    func customize(_ view: AnyView) -> CustomizeViewType
    var children: TabChild<Self> { get }
    
    associatedtype Route: TabRoute
    func resolveRoute(route: Route) -> AnyCoordinatable
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
