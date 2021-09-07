import Foundation

public class ViewRouter<T>: Routable {    
    /// The route that is currently being shown. If nil, will show the view returned by the `start` function in the Coordinator.
    public var activeRoute: T? {
        get {
            return _activeRoute()
        } set {
            _route(newValue)
        }
    }
    
    private let _activeRoute: () -> T?
    private let _route: (T?) -> Void
    
    init<U: ViewCoordinatable>(_ coordinator: U) where U.Route == T {
        _route = { viewRoute in
            coordinator.children.activeRoute = viewRoute
        }
        
        _activeRoute = {
            return coordinator.children.activeRoute
        }
    }
}
