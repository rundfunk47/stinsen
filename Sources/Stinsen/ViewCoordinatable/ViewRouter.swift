import Foundation

public class ViewRouter<T: ViewRoute>: Routable {
    private let routable: ViewRoutable
    
    public func route(to route: T) {
        routable.anyRoute(to: route)
    }
    
    init<U: ViewCoordinatable>(_ coordinator: U) {
        self.routable = ViewRoutable(coordinator: coordinator)
    }
}
