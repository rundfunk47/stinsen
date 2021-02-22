import Foundation

public class NavigationRouter<T: NavigationCoordinatable>: ObservableObject {
    private let coordinator: T
    var parent: AnyCoordinatable?
    public let id: Int?
    
    public func route(to route: T.CoordinatorRoute) {
        coordinator.route(to: route)
    }
    
    public func dismiss() {
        if parent!.children.activeChildCoordinator?.id == coordinator.id {
            parent!.children.activeChildCoordinator = nil
        } else if parent!.children.activeModalChildCoordinator?.id == coordinator.id {
            parent!.children.activeModalChildCoordinator = nil
        } else {
            fatalError("cannot dismiss, not presented")
        }
    }
    
    init(id: Int?, coordinator: T, parent: AnyCoordinatable?) {
        self.id = id
        self.coordinator = coordinator
        self.parent = parent
    }
}
