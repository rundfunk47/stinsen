import Foundation
import Combine

/// Represents a stack of routes
public class NavigationStack: ObservableObject {
    public func popTo<T: Coordinatable>(_ coordinator: T) {
        let index = value.firstIndex { tuple in
            let presentable = tuple.presentable
            
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
    
    @Published private (set) var value: [Transition]
    
    public init() {
        self.value = []
        self.dismissalAction = {}
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
    
    func append(_ transition: Transition) {
        self.value.append(transition)
    }
    
    var childCoordinators: [AnyCoordinatable] {
        return value.compactMap {
            switch $0 {
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
