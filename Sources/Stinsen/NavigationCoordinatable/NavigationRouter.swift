import Foundation
import SwiftUI

public final class NavigationRouter<T: NavigationCoordinatable>: Routable {
    public let id: Int
    fileprivate weak var coordinator: T!
    
    init(id: Int, coordinator: T) {
        self.id = id
        self.coordinator = coordinator
    }
}

public extension NavigationRouter {
    /**
     Clears the stack.
     */
    @discardableResult func popToRoot() -> T {
        coordinator.popToRoot()
    }
    
    /**
     Appends a view to the navigation stack.

     - Parameter route: The route to append.
     - Parameter input: The parameters that are used to create the coordinator.
     */
    @discardableResult func route<Input, Output: View>(
        to route: KeyPath<T, Transition<T, Presentation, Input, Output>>,
        _ input: Input
    ) -> T {
        coordinator.route(to: route, input)
    }
    
    /**
     Appends a coordinator to the navigation stack.

     - Parameter route: The route to append.
     - Parameter input: The parameters that are used to create the coordinator.
     */
    @discardableResult func route<Input, Output: Coordinatable>(
        to route: KeyPath<T, Transition<T, Presentation, Input, Output>>,
        _ input: Input
    ) -> Output {
        coordinator.route(to: route, input)
    }
    
    /**
     Appends a coordinator to the navigation stack.

     - Parameter route: The route to append.
     */
    @discardableResult func route<Output: Coordinatable>(
        to route: KeyPath<T, Transition<T, Presentation, Void, Output>>
    ) -> Output {
        coordinator.route(to: route)
    }
    
    /**
     Appends a view to the navigation stack.

     - Parameter route: The route to append.
     */
    @discardableResult func route<Output: View>(
        to route: KeyPath<T, Transition<T, Presentation, Void, Output>>
    ) -> T {
        coordinator.route(to: route)
    }
    
    /**
     Searches the stack for the first route that matches the route. If found, will remove
     everything after that route.

     - Parameter route: The route that will be focused.
     
     - Throws: `FocusError.routeNotFound`
               if the route was not found in the stack.
     */
    @discardableResult func focusFirst<Output: Coordinatable>(
        _ route: KeyPath<T, Transition<T, Presentation, Void, Output>>
    ) throws -> Output {
        try coordinator.focusFirst(route)
    }
    
    /**
     Searches the stack for the first route that matches the route. If found, will remove
     everything after that route.

     - Parameter route: The route that will be focused.
     
     - Throws: `FocusError.routeNotFound`
               if the route was not found in the stack.
     */
    @discardableResult func focusFirst<Output: View>(
        _ route: KeyPath<T, Transition<T, Presentation, Void, Output>>
    ) throws -> T {
        try coordinator.focusFirst(route)
    }
    
    /**
     Searches the stack for the first route that matches the route. If found, will remove
     everything after that route.

     - Parameter route: The route that will be focused.
     - Parameter input: The input that will be considered.
     - Parameter comparator: The function to use to determine if the inputs are equal
     
     - Throws: `FocusError.routeNotFound`
               if the route was not found in the stack.
     */
    @discardableResult func focusFirst<Input, Output: Coordinatable>(
        _ route: KeyPath<T, Transition<T, Presentation, Input, Output>>,
        _ input: Input,
        comparator: @escaping (Input, Input) -> Bool
    ) throws -> Output {
        try coordinator.focusFirst(route, input, comparator: comparator)
    }
    
    /**
     Searches the stack for the first route that matches the closure. If found, will remove
     everything after that route.

     - Parameter route: The route that will be focused.
     - Parameter input: The input that will be considered.
     - Parameter comparator: The function to use to determine if the inputs are equal
     
     - Throws: `FocusError.routeNotFound`
               if the route was not found in the stack.
     */
    @discardableResult func focusFirst<Input, Output: View>(
        _ route: KeyPath<T, Transition<T, Presentation, Input, Output>>,
        _ input: Input,
        comparator: @escaping (Input, Input) -> Bool
    ) throws -> T {
        try coordinator.focusFirst(route, input, comparator: comparator)
    }
    
    /**
     Searches the stack for the first route that matches the route. If found, will remove
     everything after that route.

     - Parameter route: The route that will be focused.
     - Parameter input: The input that will be considered. Since this function assumes input is Equatable, it will use the `==` function to determine equality.
     
     - Throws: `FocusError.routeNotFound`
               if the route was not found in the stack.
     */
    @discardableResult func focusFirst<Input: Equatable, Output: Coordinatable>(
        _ route: KeyPath<T, Transition<T, Presentation, Input, Output>>,
        _ input: Input
    ) throws -> Output {
        try coordinator.focusFirst(route, input)
    }
    
    /**
     Searches the stack for the first route that matches the closure. If found, will remove
     everything after that route.

     - Parameter route: The route that will be focused.
     - Parameter input: The input that will be considered. Since this function assumes input is Equatable, it will use the `==` function to determine equality.
     
     - Throws: `FocusError.routeNotFound`
               if the route was not found in the stack.
     */
    @discardableResult func focusFirst<Input: Equatable, Output: View>(
        _ route: KeyPath<T, Transition<T, Presentation, Input, Output>>,
        _ input: Input
    ) throws -> T {
        try coordinator.focusFirst(route, input)
    }
    
    /**
     Searches the stack for the first route that matches the route. If found, will remove
     everything after that route.

     - Parameter route: The route that will be focused.
     
     - Throws: `FocusError.routeNotFound`
               if the route was not found in the stack.
     */
    @discardableResult func focusFirst<Input, Output: Coordinatable>(
        _ route: KeyPath<T, Transition<T, Presentation, Input, Output>>
    ) throws -> Output {
        try coordinator.focusFirst(route)
    }
    /**
     Searches the stack for the first route that matches the closure. If found, will remove
     everything after that route.

     - Parameter route: The route that will be focused.
     
     - Throws: `FocusError.routeNotFound`
               if the route was not found in the stack.
     */
    @discardableResult func focusFirst<Input, Output: View>(
        _ route: KeyPath<T, Transition<T, Presentation, Input, Output>>
    ) throws -> T {
        try coordinator.focusFirst(route)
    }
    
    @discardableResult func setRoot<Output: Coordinatable>(
        _ route: KeyPath<T, Transition<T, Root, Void, Output>>
    ) -> Output {
        return coordinator.setRoot(route)
    }
    
    @discardableResult func setRoot<Output: View>(
        _ route: KeyPath<T, Transition<T, Root, Void, Output>>
    ) -> T {
        return coordinator.setRoot(route)
    }
    
    @discardableResult func setRoot<Input, Output: Coordinatable>(
        _ route: KeyPath<T, Transition<T, Root, Input, Output>>,
        _ input: Input,
        comparator: @escaping (Input, Input) -> Bool
    ) -> Output {
        return coordinator.setRoot(route, input, comparator: comparator)
    }
    
    @discardableResult func setRoot<Input, Output: View>(
        _ route: KeyPath<T, Transition<T, Root, Input, Output>>,
        _ input: Input,
        comparator: @escaping (Input, Input) -> Bool
    ) -> T {
        return coordinator.setRoot(route, input, comparator: comparator)
    }
    
    @discardableResult func setRoot<Input: Equatable, Output: Coordinatable>(
        _ route: KeyPath<T, Transition<T, Root, Input, Output>>,
        _ input: Input
    ) -> Output {
        return coordinator.setRoot(route, input)
    }
    
    @discardableResult func setRoot<Input: Equatable, Output: View>(
        _ route: KeyPath<T, Transition<T, Root, Input, Output>>,
        _ input: Input
    ) -> T {
        return coordinator.setRoot(route, input)
    }
    
    func isRoot<Output: Coordinatable>(
        _ route: KeyPath<T, Transition<T, Root, Void, Output>>
    ) -> Bool {
        return coordinator.isRoot(route)
    }
    
    func isRootk<Output: View>(
        _ route: KeyPath<T, Transition<T, Root, Void, Output>>
    ) -> Bool {
        return coordinator.isRoot(route)
    }

    func isRoot<Input, Output: Coordinatable>(
        _ route: KeyPath<T, Transition<T, Root, Input, Output>>
    ) -> Bool {
        return coordinator.isRoot(route)
    }

    func isRoot<Input, Output: View>(
        _ route: KeyPath<T, Transition<T, Root, Input, Output>>
    ) -> Bool {
        return coordinator.isRoot(route)
    }

    func isRoot<Input: Equatable, Output: Coordinatable>(
        _ route: KeyPath<T, Transition<T, Root, Input, Output>>,
        _ input: Input
    ) -> Bool {
        return coordinator.isRoot(route, input)
    }

    func isRoot<Input: Equatable, Output: View>(
        _ route: KeyPath<T, Transition<T, Root, Input, Output>>,
        _ input: Input
    ) -> Bool {
        return coordinator.isRoot(route, input)
    }

    func isRoot<Input: Equatable, Output: Coordinatable>(
        _ route: KeyPath<T, Transition<T, Root, Input, Output>>,
        _ input: Input,
        comparator: @escaping (Input, Input) -> Bool
    ) -> Bool {
        return coordinator.isRoot(route, input, comparator: comparator)
    }

    func isRoot<Input: Equatable, Output: View>(
        _ route: KeyPath<T, Transition<T, Root, Input, Output>>,
        _ input: Input,
        comparator: @escaping (Input, Input) -> Bool
    ) -> Bool {
        return coordinator.isRoot(route, input, comparator: comparator)
    }
}
