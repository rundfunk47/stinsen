import Foundation
import SwiftUI

/// Wrapper around childCoordinators
/// Used so that you don't need to write @Published
public class Children: ObservableObject {
    @Published var childCoordinators: [AnyCoordinatable]
    var childDismissalAction: DismissalAction
    
    public init(_ childCoordinators: [AnyCoordinatable]) {
        self.childCoordinators = childCoordinators
        self.childDismissalAction = {}
    }
}
