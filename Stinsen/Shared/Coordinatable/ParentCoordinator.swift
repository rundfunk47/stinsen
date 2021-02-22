import Foundation

///Used to keep track of the parent
class ParentCoordinator: ObservableObject {
    var coordinator: AnyCoordinatable?
    
    init(anyCoordinatable: AnyCoordinatable?) {
        self.coordinator = anyCoordinatable
    }
    
    init<T: Coordinatable>(coordinator: T) {
        self.coordinator = coordinator.eraseToAnyCoordinatable()
    }
}
