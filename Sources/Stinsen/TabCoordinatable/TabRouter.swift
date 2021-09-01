import Foundation

public class TabRouter<T>: Routable {
    var _anyFocus: ((Any) -> Bool) throws -> Void

    public func focus(where closure: (T) -> Bool) throws {
        try _anyFocus({
            return closure($0 as! T)
        })
    }
    
    init<U: TabCoordinatable>(_ coordinator: U) where U.Route == T {
        self._anyFocus = { closure in
            try coordinator.children.focus(where: closure)
        }
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
