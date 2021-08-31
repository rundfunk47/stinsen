import Foundation

public class TabRouter<T: TabRoute>: Routable {
    private let routable: TabRoutable

    public func focus(where closure: (T) -> Bool) throws {
        try routable.anyFocus(where: {
            return closure($0 as! T)
        })
    }
    
    init<U: TabCoordinatable>(_ coordinator: U) {
        self.routable = TabRoutable(coordinator: coordinator)
    }
}

public enum TabRouterError: LocalizedError {
    case routeNotFound
    
    public var errorDescription: String {
        switch self {
        case .routeNotFound:
            return "Route not found"
        }
    }
}
