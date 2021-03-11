import Foundation
import Combine

/// Wrapper around childCoordinators
/// Used so that you don't need to write @Published
public class ViewChild: ObservableObject {
    @Published var childCoordinator: AnyCoordinatable?
    var childDismissalAction: DismissalAction
    
    public init(_ childCoordinator: AnyCoordinatable? = nil) {
        self.childCoordinator = childCoordinator
        self.childDismissalAction = {}
    }
}
