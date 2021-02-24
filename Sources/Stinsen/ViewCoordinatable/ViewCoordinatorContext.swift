import Foundation

public class ViewRouter<T: ViewCoordinatable>: ObservableObject {
    private let coordinator: T
    
    public func route(to route: T.Route) {
        coordinator.route(to: route)
    }
    
    init(_ coordinator: T) {
        self.coordinator = coordinator
    }
}
