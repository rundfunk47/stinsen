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
    
    public func dismiss() {
        let parent = root!.children.allChildren.first(where: { (it) -> Bool in
            it.children.activeChildCoordinator?.id == coordinator.id
        })
        
        if let parent = parent {
            parent.children.activeChildCoordinator = nil
        }
        
        let modalParent = root!.children.allChildren.first(where: { (it) -> Bool in
            it.children.activeModalChildCoordinator?.id == coordinator.id
        })
        
        if let modalParent = modalParent {
            modalParent.children.activeModalChildCoordinator = nil
        }
        
        if modalParent == nil && parent == nil {
            fatalError("no children, cannot dismiss?!")
        }
    }
    
    init(id: Int?, coordinator: T) {
        self.id = id
        self.coordinator = coordinator
    }
}
