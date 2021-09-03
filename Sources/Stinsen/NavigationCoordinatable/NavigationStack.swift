import Foundation
import Combine

/// Represents a stack of routes
public final class NavigationStack<Coordinator: NavigationCoordinatable>: ObservableObject {
    public var poppedTo = PassthroughSubject<Int, Never>()
    public var dismissalAction: DismissalAction

    @Published fileprivate (set) var value: [NavigationStackItem<Coordinator>]

    var ready: Bool = false
    private weak var coordinator: Coordinator?
    
    public init(_ coordinator: Coordinator, _ startup: [Coordinator.Route] = []) {
        self.value = []
        self.dismissalAction = nil
        self.coordinator = coordinator
                
        let values = startup.map { route in
            NavigationStackItem(coordinator: coordinator, route: route)
        }
        
        self.value = values
    }
    
    /**
     Clears the stack.
     */
    public func popToRoot() {
        self.popTo(-1)
    }
    
    func popTo<T: Coordinatable>(_ coordinator: T) {
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
    
    func popTo(_ int: Int) {
        if int == -1 {
            value = []
            poppedTo.send(-1)
        } else {
            value = Array(value.prefix(int + 1))
            poppedTo.send(int)
        }
    }
    
    /**
     Searches the stack for the first route that matches the closure. If found, will remove
     everything after that route.

     - Parameter predicate: A closure that takes an element of the sequence as
     its argument and returns a Boolean value indicating whether the
     element is a match.
     
     - Throws: `FocusError.routeNotFound`
               if the route was not found in the stack.
     */
    public func focusFirst(where predicate: (Coordinator.Route) -> Bool) throws {
        let offset = self.value.enumerated().first { predicate($0.element.route) }.map { $0.offset }
        
        if let offset = offset {
            self.popTo(offset)
        } else {
            throw FocusError.routeNotFound
        }
    }
    
    /**
     Appends a route to the navigation stack.

     - Parameter route: The route to append.
     */
    public func append(_ route: Coordinator.Route) {
        guard let coordinator = coordinator else { return }
        let stackItem = NavigationStackItem(coordinator: coordinator, route: route)
        self.value.append(stackItem)
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

extension NavigationStack where Coordinator.Route: Equatable {
    /**
     Searches the stack for the first route that matches route provided. If found, will remove
     everything after that route.

     - Parameter route: The route to look for.
     
     - Throws: `FocusError.routeNotFound`
               if the route was not found in the stack.
     */
    public func focusFirst(_ route: Coordinator.Route) throws {
        try self.focusFirst { $0 == route }
    }
}
