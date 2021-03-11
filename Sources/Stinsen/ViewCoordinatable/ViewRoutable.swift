import Foundation

class ViewRoutable {
    var _anyRoute: (ViewRoute) -> Void
    
    func anyRoute(to route: ViewRoute) {
        _anyRoute(route)
    }
    
    init<T: ViewCoordinatable>(coordinator: T) {
        _anyRoute = { viewRoute in
            let resolved = coordinator.resolveRoute(route: viewRoute as! T.Route)
            coordinator.children.childCoordinator = resolved
        }
    }
}
