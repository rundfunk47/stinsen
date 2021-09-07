import Foundation

public final class NavigationRouter<T>: Routable {
    private let _anyRoute: (Any) -> Void
    private let _pop: () -> Void
    private let _popTo: (Int) -> Void
    private let _dismiss: (AnyCoordinatable, @escaping () -> Void) -> Void
    private let _focusFirst: ((T) -> Bool) throws -> Void
    
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
    
    /**
     Clears the stack.
     */
    public func popToRoot() {
        _popTo(-1)
    }
    
    /**
     Searches the stack for the first route that matches the closure. If found, will remove
     everything after that route.

     - Parameter predicate: A closure that takes an element of the sequence as
     its argument and returns a Boolean value indicating whether the
     element is a match.
     
     - Throws: `FocusError.routeNotFound`
               if the route was not found in the stack.
     */
    public func focusFirst(where predicate: (T) -> Bool) throws {
        try self._focusFirst(predicate)
    }

    /**
     Dismisses the coordinator and all it's views.
     
     - Parameter onFinished: Optional closure to execute once the coordinator has dismissed.
     */
    public func dismissCoordinator(onFinished: @escaping (() -> Void) = {}) {
        _dismiss(root!, onFinished)
    }
    
    init<U: NavigationCoordinatable>(id: Int?, coordinator: U) where U.Route == T {
        self.id = id
        
        _popTo = { int in
            coordinator.navigationStack.popTo(int)
        }
        
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
        
        _focusFirst = { predicate in
            try coordinator.navigationStack.focusFirst(where: predicate)
        }
    }
}
