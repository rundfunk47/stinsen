import Foundation
import SwiftUI

///A Coordinatable usually represents some kind of flow in the app. You do not need to implement this directly if you're not toying with other types of navigation e.g. a hamburger menu, but rather you would implement TabCoordinatable, NavigationCoordinatable or ViewCoordinatable.
public protocol Coordinatable: ObservableObject, Identifiable {
    ///Returns a view for the coordinator
    func coordinatorView() -> AnyView
    var id: String { get }
    /// The active child-coordinators of the coordinator
    var childCoordinators: [AnyCoordinatable] { get }
    var appearingMetadata: AppearingMetadata? { get }
    func dismissChildCoordinator(_ childCoordinator: AnyCoordinatable, _ completion: (() -> Void)?)
    var childDismissalAction: DismissalAction { get set }
}

public typealias DismissalAction = () -> Void

extension Coordinatable {
    var allChildCoordinators: [AnyCoordinatable] {
        return childCoordinators.flatMap { [$0] + $0.allChildCoordinators }
    }
}

public extension Coordinatable {
    var id: String {
        return ObjectIdentifier(self).debugDescription + NSStringFromClass(Self.self) //objc-name for better debugging
    }
}
