import Foundation
import Combine

/// Represents a stack of routes
public final class NavigationStack<Coordinator: NavigationCoordinatable>: ObservableObject {
    public func popTo<T: Coordinatable>(_ coordinator: T) {
        let index = value.firstIndex { tuple in
            let presentable = tuple.transition.presentable
            
            if let presentable = presentable as? AnyCoordinatable {
                return coordinator.id == presentable.id
            } else {
                return false
            }
        }!

        self.value = Array(self.value.prefix(index))
        self.poppedTo.send(index - 1)
    }
    
    public var poppedTo = PassthroughSubject<Int, Never>()
    public var dismissalAction: DismissalAction

    @Published private (set) var value: [(route: Coordinator.Route, transition: Transition)]

    var ready: Bool = false
    private weak var coordinator: Coordinator?
    
    public init(_ coordinator: Coordinator, _ startup: [Coordinator.Route] = []) {
        self.value = []
        self.dismissalAction = nil
        self.coordinator = coordinator
                
        let values = startup.map { route in
            (route: route, coordinator.resolveRoute(route: route))
        }
        
        self.value = values
    }
    
    public func popTo(_ int: Int) {
        if int == -1 {
            value = []
            poppedTo.send(-1)
        } else {
            value = Array(value.prefix(int + 1))
            poppedTo.send(int)
        }
    }
    
    func append(_ route: Coordinator.Route) {
        guard let coordinator = coordinator else { return }
        let transition = coordinator.resolveRoute(route: route)
        self.value.append((route, transition))
    }
    
    var childCoordinators: [AnyCoordinatable] {
        return value.compactMap {
            switch $0.transition {
            case .modal(let presentable):
                return presentable as? AnyCoordinatable
            case .push(let presentable):
                return presentable as? AnyCoordinatable
            case .fullScreen(let presentable):
                return presentable as? AnyCoordinatable
            }
        }
    }
}
