import Foundation

/// Wrapper around childCoordinators
/// Used so that you don't need to write @Published
public class TabChild<Coordinator: TabCoordinatable>: ObservableObject {
    @Published var childCoordinator: AnyCoordinatable
    var dismissalAction: DismissalAction
    var value: [(Coordinator.Route, AnyCoordinatable)]
    private let tabRoutes: [Coordinator.Route]
    public var activeRoute: Coordinator.Route
    
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
        
        throw TabRouterError.routeNotFound
    }
    
    public func focus(where closure: (Coordinator.Route) -> Bool) throws {
        self.activeTab = try TabChild<Coordinator>.tabNumber(tabRoutes: tabRoutes, where: closure)
    }
}
