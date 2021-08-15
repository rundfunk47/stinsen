import Foundation
import SwiftUI

@available(*, deprecated, renamed: "NavigationViewCoordinator")
public class NavigationViewCoordinatable<U: View>: NavigationViewCoordinator<U> {
    
}

/// The NavigationViewCoordinator is used to represent a coordinator with a NavigationView
public class NavigationViewCoordinator<U: View>: Coordinatable {
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
    var customize: (AnyView) -> U

    public func coordinatorView() -> AnyView {
        AnyView(
            NavigationViewCoordinatorView(coordinator: self, customize: customize)
        )
    }
    
    public init<T: Coordinatable>(_ childCoordinator: T, customize: @escaping (_ view: AnyView) -> U) {
        self.children = NavigationViewChild(childCoordinator.eraseToAnyCoordinatable())
        self.customize = customize
    }
}

public extension NavigationViewCoordinator where U == AnyView {
    convenience init<T: Coordinatable>(_ childCoordinator: T) {
        self.init(childCoordinator, customize: { $0 })
    }
}
