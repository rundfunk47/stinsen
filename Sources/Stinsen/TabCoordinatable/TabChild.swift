import Foundation

/// Wrapper around childCoordinators
/// Used so that you don't need to write @Published
public class TabChild<Coordinator: TabCoordinatable>: ObservableObject {
    @Published var childCoordinator: AnyCoordinatable
    var dismissalAction: DismissalAction
    var value: [(Coordinator.Route, AnyCoordinatable)]
    private let tabRoutes: [Coordinator.Route]
    
    /// The route that represents the currently selected tab. To set this, use the `focus` function.
    public private(set) var activeRoute: Coordinator.Route
    
    private var _activeTab: Int!

    var activeTab: Int {
        didSet {
            guard oldValue != activeTab else { return }
            let route = value[activeTab]
            self.activeRoute = route.0
            self.childCoordinator = route.1
        }
    }

    public init(
        _ coordinator: Coordinator,
        tabRoutes: [Coordinator.Route],
        startingRoute: ((Coordinator.Route) -> Bool)? = nil
    ) {
        self.tabRoutes = tabRoutes
        self.dismissalAction = nil
        
        let values = tabRoutes.map { route in
            (route: route, coordinator.resolveRoute(route: route))
        }
        
        self.value = values
        
        if let startingRoute = startingRoute {
            activeTab = try! TabChild<Coordinator>.tabNumber(tabRoutes: tabRoutes, where: startingRoute)
        } else {
            activeTab = 0
        }
        
        let route = values[activeTab]
        self.activeRoute = route.0
        self.childCoordinator = route.1
    }
    
    private static func tabNumber(
        tabRoutes: [Coordinator.Route],
        where closure: (Coordinator.Route) -> Bool
    ) throws -> Int {
        if let tab = tabRoutes.enumerated().first(where: { tuple in
            return closure(tuple.element)
        }) {
            return tab.offset
        }
        
        throw FocusError.routeNotFound
    }
    
    /**
     Searches the selectable tabs for the first route that matches the closure. If found, will make that tab the active one.

     - Parameter predicate: A closure that takes an element of the sequence as
     its argument and returns a Boolean value indicating whether the
     element is a match.
     
     - Throws: `FocusError.routeNotFound`
               if the route was not found.
     */
    public func focus(where predicate: (Coordinator.Route) -> Bool) throws {
        self.activeTab = try TabChild<Coordinator>.tabNumber(tabRoutes: tabRoutes, where: predicate)
    }
}

extension TabChild where Coordinator.Route: Equatable {
    /**
     Searches the selectable tabs for the first route that is equal to the route provided. If found, will make that tab the active one.

     - Parameter route: The route to look for.
     
     - Throws: `FocusError.routeNotFound`
               if the route was not found.
     */
    public func focus(_ route: Coordinator.Route) throws {
        try self.focus(where: { $0 == route })
    }
}
