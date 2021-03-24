import Foundation

/// Wrapper around childCoordinators
/// Used so that you don't need to write @Published
public class TabChild<T: TabCoordinatable>: ObservableObject {
    @Published var childCoordinator: AnyCoordinatable
    var dismissalAction: DismissalAction
    let coordinator: T
    let coordinators: [(T.Route, AnyCoordinatable)]
    
    public var activeTab: Int {
        get {
            return coordinators.firstIndex { tuple in
                tuple.1.id == childCoordinator.id
            }!
        } set {
            childCoordinator = coordinators[newValue].1
        }
    }
    
    public init(_ coordinator: T, tabRoutes: [T.Route], staringRoute: Int = 0) {
        self.coordinator = coordinator
        self.dismissalAction = {}

        self.coordinators = tabRoutes.map { it in
            return (it, coordinator.resolveRoute(route: it))
        }
        
        self.childCoordinator = self.coordinators[staringRoute].1
    }
    
    func route(to route: T.Route) {
        let coordinator = coordinators.first { (it) -> Bool in
            it.0.isEqual(to: route)
        }!.1
        
        self.childCoordinator = coordinator
    }
}
