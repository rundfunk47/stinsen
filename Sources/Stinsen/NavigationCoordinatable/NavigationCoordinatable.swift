import Foundation
import SwiftUI
import Combine

public protocol NavigationCoordinatable: Coordinatable {
    typealias Route = NavigationRoute
    typealias Router = NavigationRouter<Self>
    associatedtype CustomizedViewType: View
    
    var stack: NavigationStack<Self> { get }

    @ViewBuilder func customize(_ view: AnyView) -> CustomizedViewType
    
    /**
     Clears the stack.
     */
    @discardableResult func popToRoot() -> Self

    /**
     Appends a view to the navigation stack.

     - Parameter route: The route to append.
     - Parameter input: The parameters that are used to create the coordinator.
     */
    @discardableResult func route<Input, Output: View>(
        to route: KeyPath<Self, Transition<Self, Presentation, Input, Output>>,
        _ input: Input
    ) -> Self
    
    /**
     Appends a coordinator to the navigation stack.

     - Parameter route: The route to append.
     - Parameter input: The parameters that are used to create the coordinator.
     */
    @discardableResult func route<Input, Output: Coordinatable>(
        to route: KeyPath<Self, Transition<Self, Presentation, Input, Output>>,
        _ input: Input
    ) -> Output
    
    /**
     Appends a coordinator to the navigation stack.

     - Parameter route: The route to append.
     */
    @discardableResult func route<Output: Coordinatable>(
        to route: KeyPath<Self, Transition<Self, Presentation, Void, Output>>
    ) -> Output
    
    /**
     Appends a view to the navigation stack.

     - Parameter route: The route to append.
     */
    @discardableResult func route<Output: View>(
        to route: KeyPath<Self, Transition<Self, Presentation, Void, Output>>
    ) -> Self
    
    /**
     Searches the stack for the first route that matches the route. If found, will remove
     everything after that route.

     - Parameter route: The route that will be focused.
     
     - Throws: `FocusError.routeNotFound`
               if the route was not found in the stack.
     */
    @discardableResult func focusFirst<Output: Coordinatable>(
        _ route: KeyPath<Self, Transition<Self, Presentation, Void, Output>>
    ) throws -> Output
    
    /**
     Searches the stack for the first route that matches the route. If found, will remove
     everything after that route.

     - Parameter route: The route that will be focused.
     
     - Throws: `FocusError.routeNotFound`
               if the route was not found in the stack.
     */
    @discardableResult func focusFirst<Output: View>(
        _ route: KeyPath<Self, Transition<Self, Presentation, Void, Output>>
    ) throws -> Self
    
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
        _ route: KeyPath<Self, Transition<Self, Presentation, Input, Output>>,
        _ input: Input,
        comparator: @escaping (Input, Input) -> Bool
    ) throws -> Output
    
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
        _ route: KeyPath<Self, Transition<Self, Presentation, Input, Output>>,
        _ input: Input,
        comparator: @escaping (Input, Input) -> Bool
    ) throws -> Self
    
    /**
     Searches the stack for the first route that matches the route. If found, will remove
     everything after that route.

     - Parameter route: The route that will be focused.
     - Parameter input: The input that will be considered. Since this function assumes input is Equatable, it will use the `==` function to determine equality.
     
     - Throws: `FocusError.routeNotFound`
               if the route was not found in the stack.
     */
    @discardableResult func focusFirst<Input: Equatable, Output: Coordinatable>(
        _ route: KeyPath<Self, Transition<Self, Presentation, Input, Output>>,
        _ input: Input
    ) throws -> Output
    
    /**
     Searches the stack for the first route that matches the closure. If found, will remove
     everything after that route.

     - Parameter route: The route that will be focused.
     - Parameter input: The input that will be considered. Since this function assumes input is Equatable, it will use the `==` function to determine equality.
     
     - Throws: `FocusError.routeNotFound`
               if the route was not found in the stack.
     */
    @discardableResult func focusFirst<Input: Equatable, Output: View>(
        _ route: KeyPath<Self, Transition<Self, Presentation, Input, Output>>,
        _ input: Input
    ) throws -> Self
    
    /**
     Searches the stack for the first route that matches the route. If found, will remove
     everything after that route.

     - Parameter route: The route that will be focused.
     
     - Throws: `FocusError.routeNotFound`
               if the route was not found in the stack.
     */
    @discardableResult func focusFirst<Input, Output: Coordinatable>(
        _ route: KeyPath<Self, Transition<Self, Presentation, Input, Output>>
    ) throws -> Output
    
    /**
     Searches the stack for the first route that matches the closure. If found, will remove
     everything after that route.

     - Parameter route: The route that will be focused.
     
     - Throws: `FocusError.routeNotFound`
               if the route was not found in the stack.
     */
    @discardableResult func focusFirst<Input, Output: View>(
        _ route: KeyPath<Self, Transition<Self, Presentation, Input, Output>>
    ) throws -> Self
    
    @discardableResult func setRoot<Output: Coordinatable>(
        _ route: KeyPath<Self, Transition<Self, Root, Void, Output>>
    ) -> Output
    
    @discardableResult func setRoot<Output: View>(
        _ route: KeyPath<Self, Transition<Self, Root, Void, Output>>
    ) -> Self
    
    @discardableResult func setRoot<Input, Output: Coordinatable>(
        _ route: KeyPath<Self, Transition<Self, Root, Input, Output>>,
        _ input: Input,
        comparator: @escaping (Input, Input) -> Bool
    ) -> Output
    
    @discardableResult func setRoot<Input, Output: View>(
        _ route: KeyPath<Self, Transition<Self, Root, Input, Output>>,
        _ input: Input,
        comparator: @escaping (Input, Input) -> Bool
    ) -> Self
    
    @discardableResult func setRoot<Input: Equatable, Output: Coordinatable>(
        _ route: KeyPath<Self, Transition<Self, Root, Input, Output>>,
        _ input: Input
    ) -> Output
    
    @discardableResult func setRoot<Input: Equatable, Output: View>(
        _ route: KeyPath<Self, Transition<Self, Root, Input, Output>>,
        _ input: Input
    ) -> Self
    
    func isRoot<Output: Coordinatable>(
        _ route: KeyPath<Self, Transition<Self, Root, Void, Output>>
    ) -> Bool
    
    func isRoot<Output: View>(
        _ route: KeyPath<Self, Transition<Self, Root, Void, Output>>
    ) -> Bool

    func isRoot<Input, Output: Coordinatable>(
        _ route: KeyPath<Self, Transition<Self, Root, Input, Output>>
    ) -> Bool

    func isRoot<Input, Output: View>(
        _ route: KeyPath<Self, Transition<Self, Root, Input, Output>>
    ) -> Bool

    func isRoot<Input: Equatable, Output: Coordinatable>(
        _ route: KeyPath<Self, Transition<Self, Root, Input, Output>>,
        _ input: Input
    ) -> Bool

    func isRoot<Input: Equatable, Output: View>(
        _ route: KeyPath<Self, Transition<Self, Root, Input, Output>>,
        _ input: Input
    ) -> Bool

    func isRoot<Input: Equatable, Output: Coordinatable>(
        _ route: KeyPath<Self, Transition<Self, Root, Input, Output>>,
        _ input: Input,
        comparator: @escaping (Input, Input) -> Bool
    ) -> Bool

    func isRoot<Input: Equatable, Output: View>(
        _ route: KeyPath<Self, Transition<Self, Root, Input, Output>>,
        _ input: Input,
        comparator: @escaping (Input, Input) -> Bool
    ) -> Bool
}

public extension NavigationCoordinatable {
    internal func setupRoot() {
        let a = self[keyPath: self.stack.initialRoute] as! NavigationOutputable
        let presentable = a.using(coordinator: self, input: ())
        
        let item = NavigationRootItem(
            keyPath: self.stack.initialRoute.hashValue,
            input: self.stack.initialInput,
            child: presentable
        )
        
        self.stack.root = NavigationRoot(item: item)
    }
    
    internal func appear(_ int: Int) {        
        self.popTo(int)
    }
    
    internal func popTo(_ int: Int) {
        guard int + 1 <= self.stack.value.count else {
            return
        }
        
        if int == -1 {
            self.stack.value = []
            self.stack.poppedTo.send(-1)
        } else {
            self.stack.value = Array(self.stack.value.prefix(int + 1))
            self.stack.poppedTo.send(int)
        }
    }
    
    func view() -> AnyView {
        return AnyView(NavigationCoordinatableView(id: -1, coordinator: self))
    }

    func popToRoot() -> Self {
        self.popTo(-1)
        return self
    }
    
    @discardableResult func route<Input, Output: Coordinatable>(
        to route: KeyPath<Self, Transition<Self, Presentation, Input, Output>>,
        _ input: Input
    ) -> Output {
        let transition = self[keyPath: route]
        let output = transition.closure(self)(input)
        stack.value.append(
            NavigationStackItem(
                presentationType: transition.type.type,
                presentable: output,
                keyPath: route.hashValue,
                input: input
            )
        )
        return output
    }
    
    @discardableResult func route<Output: Coordinatable>(
        to route: KeyPath<Self, Transition<Self, Presentation, Void, Output>>
    ) -> Output {
        let transition = self[keyPath: route]
        let output = transition.closure(self)(())
        stack.value.append(
            NavigationStackItem(
                presentationType: transition.type.type,
                presentable: output,
                keyPath: route.hashValue,
                input: nil
            )
        )
        return output
    }
    
    @discardableResult func route<Input, Output: View>(
        to route: KeyPath<Self, Transition<Self, Presentation, Input, Output>>,
        _ input: Input
    ) -> Self {
        let transition = self[keyPath: route]
        let output = transition.closure(self)(input)
        self.stack.value.append(
            NavigationStackItem(
                presentationType: transition.type.type,
                presentable: output,
                keyPath: route.hashValue,
                input: input
            )
        )
        return self
    }
    
    @discardableResult func route<Output: View>(
        to route: KeyPath<Self, Transition<Self, Presentation, Void, Output>>
    ) -> Self {
        let transition = self[keyPath: route]
        let output = transition.closure(self)(())
        self.stack.value.append(
            NavigationStackItem(
                presentationType: transition.type.type,
                presentable: output,
                keyPath: route.hashValue,
                input: nil
            )
        )
        return self
    }

    @discardableResult private func _focusFirst<Input, Output: Coordinatable>(
        _ route: KeyPath<Self, Transition<Self, Presentation, Input, Output>>,
        _ input: (value: Input, comparator: ((Input, Input) -> Bool))?
    ) throws -> Output {
        guard let value = stack.value.enumerated().first(where: { item in
            guard item.element.keyPath == route.hashValue else {
                return false
            }
            
            guard let input = input else {
                return true
            }
            
            guard let compareTo = item.element.input else {
                fatalError()
            }
            
            return input.comparator(compareTo as! Input, input.value)
        }) else {
            throw FocusError.routeNotFound
        }
        
        self.popTo(value.offset)
        
        return value.element.presentable as! Output
    }
    
    @discardableResult private func _focusFirst<Input, Output: View>(
        _ route: KeyPath<Self, Transition<Self, Presentation, Input, Output>>,
        _ input: (value: Input, comparator: ((Input, Input) -> Bool))?
    ) throws -> Self {
        guard let value = stack.value.enumerated().first(where: { item in
            guard item.element.keyPath == route.hashValue else {
                return false
            }
            
            guard let input = input else {
                return true
            }
            
            guard let compareTo = item.element.input else {
                fatalError()
            }
            
            return input.comparator(compareTo as! Input, input.value)
        }) else {
            throw FocusError.routeNotFound
        }
        
        self.popTo(value.offset)
        
        return self
    }
    
    @discardableResult func focusFirst<Output: Coordinatable>(
        _ route: KeyPath<Self, Transition<Self, Presentation, Void, Output>>
    ) throws -> Output {
        try self._focusFirst(route, nil)
    }
    
    @discardableResult func focusFirst<Output: View>(
        _ route: KeyPath<Self, Transition<Self, Presentation, Void, Output>>
    ) throws -> Self {
        try self._focusFirst(route, nil)
    }
    
    @discardableResult func focusFirst<Input, Output: Coordinatable>(
        _ route: KeyPath<Self, Transition<Self, Presentation, Input, Output>>,
        _ input: Input,
        comparator: @escaping (Input, Input) -> Bool
    ) throws -> Output {
        try self._focusFirst(route, (value: input, comparator: comparator))
    }
    
    @discardableResult func focusFirst<Input, Output: View>(
        _ route: KeyPath<Self, Transition<Self, Presentation, Input, Output>>,
        _ input: Input,
        comparator: @escaping (Input, Input) -> Bool
    ) throws -> Self {
        try self._focusFirst(route, (value: input, comparator: comparator))
    }
    
    @discardableResult func focusFirst<Input: Equatable, Output: Coordinatable>(
        _ route: KeyPath<Self, Transition<Self, Presentation, Input, Output>>,
        _ input: Input
    ) throws -> Output {
        try self._focusFirst(route, (value: input, comparator: { $0 == $1 }))
    }
    
    @discardableResult func focusFirst<Input: Equatable, Output: View>(
        _ route: KeyPath<Self, Transition<Self, Presentation, Input, Output>>,
        _ input: Input
    ) throws -> Self {
        try self._focusFirst(route, (value: input, comparator: { $0 == $1 }))
    }
    
    @discardableResult func focusFirst<Input, Output: Coordinatable>(
        _ route: KeyPath<Self, Transition<Self, Presentation, Input, Output>>
    ) throws -> Output {
        try self._focusFirst(route, nil)
    }
    
    @discardableResult func focusFirst<Input, Output: View>(
        _ route: KeyPath<Self, Transition<Self, Presentation, Input, Output>>
    ) throws -> Self {
        try self._focusFirst(route, nil)
    }
    
    @discardableResult private func _setRoot<Output: Coordinatable, Input>(
        _ route: KeyPath<Self, Transition<Self, Root, Input, Output>>,
        inputItem: (input: Input, comparator: (Input, Input) -> Bool)?
    ) -> Output {
        if stack.root.item.keyPath == route.hashValue {
            if let inputItem = inputItem {
                if inputItem.comparator(inputItem.input, stack.root.item.input! as! Input) == true {
                    return stack.root.item.child as! Output
                }
            } else {
                return stack.root.item.child as! Output
            }
        }
        
        let output: Output
        
        if let input = inputItem?.input {
            output = self[keyPath: route].closure(self)(input)
        } else {
            output = self[keyPath: route].closure(self)(() as! Input)
        }
        
        stack.root.item = NavigationRootItem(
            keyPath: route.hashValue,
            input: inputItem?.input,
            child: output
        )
        
        return output
    }
    
    @discardableResult private func _setRoot<Output: View, Input>(
        _ route: KeyPath<Self, Transition<Self, Root, Input, Output>>,
        inputItem: (input: Input, comparator: (Input, Input) -> Bool)?
    ) -> Self {
        if stack.root.item.keyPath == route.hashValue {
            if let inputItem = inputItem {
                if inputItem.comparator(inputItem.input, stack.root.item.input! as! Input) == true {
                    return self
                }
            } else {
                return self
            }
        }
        
        let output: Output
        
        if let input = inputItem?.input {
            output = self[keyPath: route].closure(self)(input)
        } else {
            output = self[keyPath: route].closure(self)(() as! Input)
        }
        
        stack.root.item = NavigationRootItem(
            keyPath: route.hashValue,
            input: inputItem?.input,
            child: AnyView(output)
        )
        
        return self
    }
    
    @discardableResult func setRoot<Output: Coordinatable>(
        _ route: KeyPath<Self, Transition<Self, Root, Void, Output>>
    ) -> Output {
        self._setRoot(route, inputItem: nil)
    }
    
    @discardableResult func setRoot<Output: View>(
        _ route: KeyPath<Self, Transition<Self, Root, Void, Output>>
    ) -> Self {
        self._setRoot(route, inputItem: nil)
    }
    
    @discardableResult func setRoot<Input, Output: Coordinatable>(
        _ route: KeyPath<Self, Transition<Self, Root, Input, Output>>,
        _ input: Input,
        comparator: @escaping (Input, Input) -> Bool
    ) -> Output {
        self._setRoot(route, inputItem: (input, comparator))
    }
    
    @discardableResult func setRoot<Input, Output: View>(
        _ route: KeyPath<Self, Transition<Self, Root, Input, Output>>,
        _ input: Input,
        comparator: @escaping (Input, Input) -> Bool
    ) -> Self {
        self._setRoot(route, inputItem: (input, comparator))
    }
    
    @discardableResult func setRoot<Input: Equatable, Output: Coordinatable>(
        _ route: KeyPath<Self, Transition<Self, Root, Input, Output>>,
        _ input: Input
    ) -> Output {
        self._setRoot(route, inputItem: (input, { $0 == $1 }))
    }
    
    @discardableResult func setRoot<Input: Equatable, Output: View>(
        _ route: KeyPath<Self, Transition<Self, Root, Input, Output>>,
        _ input: Input
    ) -> Self {
        self._setRoot(route, inputItem: (input, { $0 == $1 }))
    }
    
    private func _isRoot<Input, Output: Coordinatable>(
        _ route: KeyPath<Self, Transition<Self, Root, Input, Output>>,
        inputItem: (input: Input, comparator: (Input, Input) -> Bool)?
    ) -> Bool {
        guard stack.root.item.keyPath == route.hashValue else {
            return false
        }
        
        guard let inputItem = inputItem else {
            return true
        }

        guard let compareTo = stack.root.item.input else {
            fatalError()
        }

        return inputItem.comparator(compareTo as! Input, inputItem.input)
    }
    
    private func _isRoot<Input, Output: View>(
        _ route: KeyPath<Self, Transition<Self, Root, Input, Output>>,
        inputItem: (input: Input, comparator: (Input, Input) -> Bool)?
    ) -> Bool {
        guard stack.root.item.keyPath == route.hashValue else {
            return false
        }
        
        guard let inputItem = inputItem else {
            return true
        }

        guard let compareTo = stack.root.item.input else {
            fatalError()
        }

        return inputItem.comparator(compareTo as! Input, inputItem.input)
    }
    
    func isRoot<Output: Coordinatable>(
        _ route: KeyPath<Self, Transition<Self, Root, Void, Output>>
    ) -> Bool {
        return self._isRoot(route, inputItem: nil)
    }
    
    func isRoot<Output: View>(
        _ route: KeyPath<Self, Transition<Self, Root, Void, Output>>
    ) -> Bool {
        return self._isRoot(route, inputItem: nil)
    }

    func isRoot<Input, Output: Coordinatable>(
        _ route: KeyPath<Self, Transition<Self, Root, Input, Output>>
    ) -> Bool {
        return self._isRoot(route, inputItem: nil)
    }

    func isRoot<Input, Output: View>(
        _ route: KeyPath<Self, Transition<Self, Root, Input, Output>>
    ) -> Bool {
        return self._isRoot(route, inputItem: nil)
    }

    func isRoot<Input: Equatable, Output: Coordinatable>(
        _ route: KeyPath<Self, Transition<Self, Root, Input, Output>>,
        _ input: Input
    ) -> Bool {
        return self._isRoot(route, inputItem: (input: input, comparator: { $0 == $1 }))
    }

    func isRoot<Input: Equatable, Output: View>(
        _ route: KeyPath<Self, Transition<Self, Root, Input, Output>>,
        _ input: Input
    ) -> Bool {
        return self._isRoot(route, inputItem: (input: input, comparator: { $0 == $1 }))
    }

    func isRoot<Input: Equatable, Output: Coordinatable>(
        _ route: KeyPath<Self, Transition<Self, Root, Input, Output>>,
        _ input: Input,
        comparator: @escaping (Input, Input) -> Bool
    ) -> Bool {
        return self._isRoot(route, inputItem: (input: input, comparator: comparator))
    }

    func isRoot<Input: Equatable, Output: View>(
        _ route: KeyPath<Self, Transition<Self, Root, Input, Output>>,
        _ input: Input,
        comparator: @escaping (Input, Input) -> Bool
    ) -> Bool {
        return self._isRoot(route, inputItem: (input: input, comparator: comparator))
    }
}
