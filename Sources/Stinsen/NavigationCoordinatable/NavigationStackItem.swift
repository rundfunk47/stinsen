import Foundation

class NavigationStackItem<Coordinator: NavigationCoordinatable> {
    let route: Coordinator.Route
    let transition: Transition
    
    init(coordinator: Coordinator, route: Coordinator.Route) {
        self.route = route
        self.transition = coordinator.resolveRoute(route: route)
    }
}
