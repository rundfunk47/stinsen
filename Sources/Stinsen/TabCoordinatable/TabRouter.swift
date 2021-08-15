import Foundation

public class TabRouter<T: TabRoute>: Routable {
    private let routable: TabRoutable

    public func route(to route: T) {
        routable.anyRoute(to: route)
    }
    
    init<U: TabCoordinatable>(_ coordinator: U) {
        self.routable = TabRoutable(coordinator: coordinator)
    }
}
