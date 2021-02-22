import Foundation

public class TabRouter<T: TabCoordinatable>: ObservableObject {
    private let coordinator: T

    public func route(to int: Int) {
        coordinator.activeTab = int
    }
    
    init(_ coordinator: T) {
        self.coordinator = coordinator
    }
}
