import Foundation

public class TabRouter<T: TabCoordinatable>: ObservableObject {
    private let coordinator: T

    public func route(to route: T.Route) {
        coordinator.children.route(to: route)
    }
    
    init(_ coordinator: T) {
        self.coordinator = coordinator
    }
}
