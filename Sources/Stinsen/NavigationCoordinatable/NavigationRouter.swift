import Foundation

public class NavigationRouter<T: NavigationCoordinatable>: ObservableObject {
    private let coordinator: T
    var root: AnyCoordinatable?
    public let id: Int?
    
    public func route(to route: T.Route) {
        coordinator.route(to: route)
    }
    
    public func pop() {
        self.coordinator.navigationStack.popTo(self.coordinator.navigationStack.value.count - 2)
    }
    
    public func dismiss(onFinished: @escaping (() -> Void) = {}) {
        guard let parent = root!.allChildCoordinators.first(where: {
            $0.childCoordinators.contains(where: {
                coordinator.id == $0.id
            })
        }) else {
            fatalError("no children, cannot dismiss?!")
        }
        
        parent.dismissChildCoordinator(coordinator.eraseToAnyCoordinatable(), onFinished)
    }
    
    init(id: Int?, coordinator: T) {
        self.id = id
        self.coordinator = coordinator
    }
}
