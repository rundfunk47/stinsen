import Foundation

class NavigationRootCoordinator: ObservableObject {
    var coordinator: AnyCoordinatable
    
    init<T: Coordinatable>(coordinator: T) {
        self.coordinator = coordinator.eraseToAnyCoordinatable()
    }
}
