import Foundation
import SwiftUI

/// Wrapper around childCoordinators
/// Used so that you don't need to write @Published
public class NavigationViewChild: ObservableObject {
    @Published var childCoordinator: AnyCoordinatable?
    var dismissalAction: DismissalAction
    
    public init(_ childCoordinator: AnyCoordinatable? = nil) {
        self.childCoordinator = childCoordinator
        self.dismissalAction = {}
    }
}
