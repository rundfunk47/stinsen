import Foundation
import SwiftUI

/// The NavigationViewCoordinatable is used to represent a coordinator with a NavigationView
public class NavigationViewCoordinatable<U: View>: Coordinatable {
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
            NavigationViewCoordinatableView(coordinator: self, customize: customize)
        )
    }
    
    public init<T: Coordinatable>(_ childCoordinator: T, customize: @escaping (_ view: AnyView) -> U) {
        self.children = NavigationViewChild(childCoordinator.eraseToAnyCoordinatable())
        self.customize = customize
    }
}

public extension NavigationViewCoordinatable where U == AnyView {
    convenience init<T: Coordinatable>(_ childCoordinator: T) {
        self.init(childCoordinator, customize: { $0 })
    }
}
