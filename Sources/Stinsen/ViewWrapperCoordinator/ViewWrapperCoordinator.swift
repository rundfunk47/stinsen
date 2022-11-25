import Foundation
import SwiftUI

/// The NavigationViewCoordinator is used to represent a coordinator with a NavigationView
open class ViewWrapperCoordinator<T: Coordinatable, V: View>: Coordinatable {
    public func dismissChild<T: Coordinatable>(coordinator: T, action: (() -> Void)?) {
        guard let parent = self.parent else {
            assertionFailure("Can not dismiss a coordinator since no coordinator is presented.")
            return
        }
        
        parent.dismissChild(coordinator: self, action: action)
    }

    public weak var parent: ChildDismissable?
    public let child: T
    private let viewFactory: (any Coordinatable) -> (AnyView) -> V

    public func view() -> AnyView {
        AnyView(
            ViewWrapperCoordinatorView(coordinator: self, viewFactory(self))
        )
    }
    
    public init(_ childCoordinator: T, _ view: @escaping (AnyView) -> V) {
        self.child = childCoordinator
        self.viewFactory = { _ in { view($0) } }
        self.child.parent = self
    }
    
    public init(_ childCoordinator: T, _ view: @escaping (any Coordinatable) -> (AnyView) -> V) {
        self.child = childCoordinator
        self.viewFactory = view
        self.child.parent = self
    }
}
