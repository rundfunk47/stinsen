import Foundation

public protocol TabResolver: AnyTabResolver {
    associatedtype Route: TabRoute
    func resolveRoute(route: Route) -> AnyCoordinatable
}

public protocol AnyTabResolver: AnyObject {
    func anyResolveRoute(route: TabRoute) -> AnyCoordinatable
}

public extension TabResolver {
    func anyResolveRoute(route: TabRoute) -> AnyCoordinatable {
        resolveRoute(route: route as! Self.Route)
    }
}
