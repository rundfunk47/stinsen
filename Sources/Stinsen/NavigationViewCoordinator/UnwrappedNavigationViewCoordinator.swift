import Foundation
import SwiftUI

/// The UnwrappedNavigationViewCoordinator represents a simplified coordinator
///
/// This class can be seen a a convenience class for creating a Coordinator view without wrapping
/// it in a NavigationView
public class UnwrappedNavigationViewCoordinator<T: Coordinatable>: ViewWrapperCoordinator<T, AnyView> {
    public init(_ childCoordinator: T) {
        super.init(childCoordinator) { view in
            AnyView(view)
        }
    }

    @available(*, unavailable)
    public override init(_ childCoordinator: T, _ view: @escaping (AnyView) -> AnyView) {
        fatalError("view cannot be customized")
    }
}
