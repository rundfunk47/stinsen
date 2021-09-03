import Foundation

public final class NavigationRouter<T>: Routable {
    private let _anyRoute: (Any) -> Void
    private let _pop: () -> Void
    private let _dismiss: (AnyCoordinatable, @escaping () -> Void) -> Void

    var root: AnyCoordinatable?
    public let id: Int?
    
    /**
     Appends a route to the navigation stack.

     - Parameter route: The route to append.
     */
    public func route(to route: T) {
        _anyRoute(route)
    }
    
    /**
     Pops the latest view/coordinator from the navigation stack.
     */
    public func pop() {
        _pop()
    }
    
    #warning("add firstroute and pop to int...")
    
    /**
     Dismisses the coordinator and all it's views.
     
     - Parameter onFinished: Optional closure to execute once the coordinator has dismissed.
     */
    public func dismissCoordinator(onFinished: @escaping (() -> Void) = {}) {
        _dismiss(root!, onFinished)
    }
    
    init<U: NavigationCoordinatable>(id: Int?, coordinator: U) where U.Route == T {
        self.id = id
        
        _pop = {
            coordinator.navigationStack.popTo(coordinator.navigationStack.value.count - 2)
        }
        
        _anyRoute = { route in
            coordinator.navigationStack.append(route as! T)
        }
        
        _dismiss = { root, onFinished in
            guard let parent = root.allChildCoordinators.first(where: {
                $0.childCoordinators.contains(where: {
                    coordinator.id == $0.id
                })
            }) else {
                fatalError("no children, cannot dismiss?!")
            }
            
            let oldAction = coordinator.dismissalAction
            coordinator.dismissalAction = {
                oldAction?()
                onFinished()
            }
            
            parent.dismissChildCoordinator(coordinator.eraseToAnyCoordinatable(), onFinished)
        }
    }
}
