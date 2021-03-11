import Foundation

class TabRoutable {
    var _anyRoute: (TabRoute) -> Void
    
    func anyRoute(to route: TabRoute) {
        _anyRoute(route)
    }
    
    init<T: TabCoordinatable>(coordinator: T) {
        _anyRoute = { tabRoute in
            let first = coordinator.children.coordinators.first {
                $0.0.isEqual(to: tabRoute)
            }!
            
            coordinator.children.childCoordinator = first.1
        }
    }
}
