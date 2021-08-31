import Foundation

class ViewRoutable {
    var _anyRoute: (ViewRoute?) -> Void
    
    func anyRoute(to route: ViewRoute?) {
        _anyRoute(route)
    }
    
    init<T: ViewCoordinatable>(coordinator: T) {
        _anyRoute = { viewRoute in
            coordinator.children.activeRoute = viewRoute as! T.Route?
        }
    }
}
