import Foundation

/// Used to mark the root of the coordinator tree. Useful for checking if for example the active coordinator even exists
public final class RootCoordinator: ObservableObject {
    public let coordinator: AnyCoordinatable
    
    init<T: Coordinatable>(coordinator: T) {
        self.coordinator = coordinator.eraseToAnyCoordinatable()
    }
}
