import Foundation
import Combine

/// Wrapper around childCoordinators
/// Used so that you don't need to write @Published
public class ViewChild<Coordinator: ViewCoordinatable>: ObservableObject {
    private weak var coordinator: Coordinator?
    @Published var childCoordinator: AnyCoordinatable?
    var dismissalAction: DismissalAction
    
    /// The route that is currently being shown. If nil, will show the view returned by the `start` function in the Coordinator.
    var activeRoute: Coordinator.Route? {
        didSet {
            guard let coordinator = coordinator else { return }
            
            if let activeRoute = activeRoute {
                let resolved = coordinator.resolveRoute(route: activeRoute)
                self.childCoordinator = resolved
            } else {
                self.childCoordinator = nil
            }
        }
    }
    
    public init(
        _ coordinator: Coordinator,
        startingRoute: Coordinator.Route? = nil
    ) {
        self.coordinator = coordinator
        self.childCoordinator = nil
        self.dismissalAction = nil
        
        if let startingRoute = startingRoute {
            activeRoute = startingRoute
        }
    }
}
