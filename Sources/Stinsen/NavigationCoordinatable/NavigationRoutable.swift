import Foundation

class NavigationRoutable {
    var _anyRoute: (NavigationRoute) -> Void
    var _pop: () -> Void
    var _dismiss: (AnyCoordinatable, @escaping () -> Void) -> Void
    
    func anyRoute(to route: NavigationRoute) {
        _anyRoute(route)
    }
    
    func pop() {
        _pop()
    }
    
    func dismiss(withRootCoordinator rootCoordinator: AnyCoordinatable, onFinished: @escaping (() -> Void)) {
        _dismiss(rootCoordinator, onFinished)
    }
    
    init<T: NavigationCoordinatable>(coordinator: T) {
        _pop = {
            coordinator.navigationStack.popTo(coordinator.navigationStack.value.count - 2)
        }
        
        _anyRoute = { route in
            let resolved = coordinator.resolveRoute(route: route as! T.Route)
            coordinator.navigationStack.append(resolved)
        }
        
        _dismiss = { root, onFinished in
            guard let parent = ([root] + root.allChildCoordinators).first(where: {
                $0.childCoordinators.contains(where: {
                    coordinator.id == $0.id
                })
            }) else {
                fatalError("no children, cannot dismiss?!")
            }
            
            let oldAction = coordinator.dismissalAction
            coordinator.dismissalAction = {
                oldAction()
                onFinished()
            }
            
            parent.dismissChildCoordinator(coordinator.eraseToAnyCoordinatable(), onFinished)
        }
    }
}
