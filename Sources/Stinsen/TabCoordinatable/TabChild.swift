import Foundation

/// Wrapper around childCoordinators
/// Used so that you don't need to write @Published
public class TabChild<Route: TabRoute>: ObservableObject {
    @Published var childCoordinator: AnyCoordinatable!
    var dismissalAction: DismissalAction
    var value: [(Route, AnyCoordinatable)]!
    private let tabRoutes: [Route]
    private let startingRoute: ((Route) -> Bool)?
    
    private var _activeTab: Int!
    private var _activeRoute: Route!

    var activeTab: Int {
        get {
            _activeTab
        } set {
            _activeTab = newValue
            let route = self.value[activeTab]
            self._activeRoute = route.0
            self.childCoordinator = route.1
        }
    }
    
    public var activeRoute: Route {
        get {
            return _activeRoute
        }
    }
    
    public weak var resolver: AnyTabResolver! {
        didSet {
            if oldValue == nil {
                let values = tabRoutes.map { route in
                    (route: route, resolver.anyResolveRoute(route: route))
                }
                
                self.value = values
                
                if let startingRoute = startingRoute {
                    try! focus(where: startingRoute)
                } else {
                    activeTab = 0
                }
            }
        }
    }

    public init(_ tabRoutes: [Route], startingRoute: ((Route) -> Bool)? = nil) {
        self.tabRoutes = tabRoutes
        self.dismissalAction = nil
        self.startingRoute = startingRoute
    }
    
    public func focus(where closure: (Route) -> Bool) throws {
        if let tab = self.tabRoutes.enumerated().first(where: { tuple in
            return closure(tuple.element)
        }) {
            self.activeTab = tab.offset
        }
        
        throw TabRouterError.routeNotFound
    }
}
