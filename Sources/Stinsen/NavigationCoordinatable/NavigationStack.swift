import Foundation
import Combine

/// Represents a stack of routes
public class NavigationStack: AppearingMetadata, ObservableObject {    
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
    
    public var appearing: Int?
    public var poppedTo = PassthroughSubject<Int, Never>()
    public var childDismissalAction: DismissalAction
    
    @Published private (set) var value: [Transition]
    
    public init() {
        self.value = []
        self.childDismissalAction = {}
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
        
        if transition.presentable is AnyCoordinatable {
            appearing = nil
        }
    }
    
    var childCoordinators: [AnyCoordinatable] {
        return value.compactMap {
            switch $0 {
            case .modal(let presentable):
                return presentable as? AnyCoordinatable
            case .push(let presentable):
                return presentable as? AnyCoordinatable
            }
        }
    }
}

public protocol AppearingMetadata {
    // Helper variable to keep track of which view with ID that is appearing. SwiftUI has no easy way of knowing when the user presses the back button, so the way we know the user is popping the stack is that the appearing ID is less than the stack count.
    var appearing: Int? { get set }
    func popTo(_ int: Int)
}
