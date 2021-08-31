import Foundation
import Combine

/// Wrapper around childCoordinators
/// Used so that you don't need to write @Published
public class ViewChild<Route: ViewRoute>: ObservableObject {
    @Published var childCoordinator: AnyCoordinatable?
    var dismissalAction: DismissalAction
    
    var activeRoute: Route? {
        didSet {
            if let activeRoute = activeRoute {
                let resolved = resolver.anyResolveRoute(route: activeRoute)
                self.childCoordinator = resolved
            } else {
                self.childCoordinator = nil
            }
        }
    }
    
    var startingRoute: Route?

    public weak var resolver: AnyViewResolver! {
        didSet {
            if oldValue == nil {
                if let startingRoute = startingRoute {
                    activeRoute = startingRoute
                }
            }
        }
    }
    
    public init(_ startingRoute: Route? = nil) {
        self.childCoordinator = nil
        self.dismissalAction = nil
    }
}
