import Foundation

public protocol NavigationResolver: AnyNavigationResolver {
    associatedtype Route: NavigationRoute
    func resolveRoute(route: Route) -> Transition
}

public protocol AnyNavigationResolver: AnyObject {
    func anyResolveRoute(route: NavigationRoute) -> Transition
}

public extension NavigationResolver {
    func anyResolveRoute(route: NavigationRoute) -> Transition {
        resolveRoute(route: route as! Self.Route)
    }
}
