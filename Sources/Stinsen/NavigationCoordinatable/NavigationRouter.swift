import Foundation

public class NavigationRouter<T: NavigationRoute>: Routable {
    private let routable: NavigationRoutable
    var root: AnyCoordinatable?
    public let id: Int?
    
    public func route(to route: T) {
        routable.anyRoute(to: route)
    }
    
    public func pop() {
        routable.pop()
    }
    
    public func dismiss(onFinished: @escaping (() -> Void) = {}) {
        routable.dismiss(withRootCoordinator: root!, onFinished: onFinished)
    }
    
    init<U: NavigationCoordinatable>(id: Int?, coordinator: U) {
        self.id = id
        self.routable = NavigationRoutable(coordinator: coordinator)
    }
}
