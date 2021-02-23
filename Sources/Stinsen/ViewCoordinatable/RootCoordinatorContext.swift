import Foundation

public class RootRouter<T: ViewCoordinatable>: ObservableObject {
    private let coordinator: T
    
    public func route(to route: T.Route) {
        coordinator.route(to: route)
    }
    
    init(_ coordinator: T) {
        self.coordinator = coordinator
    }
}
