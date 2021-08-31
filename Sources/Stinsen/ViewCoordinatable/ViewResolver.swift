import Foundation

public protocol ViewResolver: AnyViewResolver {
    associatedtype Route: ViewRoute
    func resolveRoute(route: Route) -> AnyCoordinatable
}

public protocol AnyViewResolver: AnyObject {
    func anyResolveRoute(route: ViewRoute) -> AnyCoordinatable
}

public extension ViewResolver {
    func anyResolveRoute(route: ViewRoute) -> AnyCoordinatable {
        resolveRoute(route: route as! Self.Route)
    }
}
