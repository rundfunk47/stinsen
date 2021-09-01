import Foundation

public class ViewRouter<T>: Routable {
    public func route(to route: T?) {
        _anyRoute(route)
    }
    
    private let _anyRoute: (T?) -> Void
    
    init<U: ViewCoordinatable>(_ coordinator: U) where U.Route == T {
        _anyRoute = { viewRoute in
            coordinator.children.activeRoute = viewRoute
        }
    }
}
