import Foundation
import SwiftUI

public class ViewRouter<T: ViewCoordinatable>: Routable {
    private weak var coordinator: T!
    
    init(_ coordinator: T) {
        self.coordinator = coordinator
    }
}

public extension ViewRouter {
    /**
     Changes the active route.

     - Parameter route: The route to switch to.
     - Parameter input: The parameters that are used to create the coordinator.
     - Parameter comparator: The function to use to determine if the inputs are equal
     */
    @discardableResult func route<Input, Output: Coordinatable>(
        to route: KeyPath<T, ((T) -> ((Input) -> Output))>,
        _ input: Input,
        comparator: @escaping (Input, Input) -> Bool
    ) -> Output {
        return coordinator.route(to: route, input, comparator: comparator)
    }
    
    /**
     Changes the active route.

     - Parameter route: The route to switch to.
     - Parameter input: The parameters that are used to create the coordinator. If input conforms to `Equatable`, there is no need to add a comparator unless you need it.
     */
    @discardableResult func route<Input: Equatable, Output: Coordinatable>(
        to route: KeyPath<T, ((T) -> ((Input) -> Output))>,
        _ input: Input
    ) -> Output {
        return coordinator.route(to: route, input)
    }
    
    /**
     Changes the active route.

     - Parameter route: The route to switch to.
     - Parameter input: The parameters that are used to create the view.
     - Parameter comparator: The function to use to determine if the inputs are equal
     */
    @discardableResult func route<Input, Output: View>(
        to route: KeyPath<T, ((T) -> ((Input) -> Output))>,
        _ input: Input,
        comparator: @escaping (Input, Input) -> Bool
    ) -> Output {
        return coordinator.route(to: route, input, comparator: comparator)
    }
    
    /**
     Changes the active route.

     - Parameter route: The route to switch to.
     - Parameter input: The parameters that are used to create the view. If input conforms to `Equatable`, there is no need to add a comparator unless you need it.
     */
    @discardableResult func route<Input: Equatable, Output: View>(
        to route: KeyPath<T, ((T) -> ((Input) -> Output))>,
        _ input: Input
    ) -> Output {
        return coordinator.route(to: route, input)
    }
    
    /**
     Changes the active route.

     - Parameter route: The route to switch to.
     */
    @discardableResult func route<Output: Coordinatable>(
        to route: KeyPath<T, (T) -> ((Void) -> Output)>
    ) -> Output {
        coordinator.route(to: route)
    }
    
    /**
     Changes the active route.

     - Parameter route: The route to switch to.
     */
    @discardableResult func route<Output: View>(
        to route: KeyPath<T, ((T) -> ((Void) -> Output))>
    ) -> Output {
        return coordinator.route(to: route)
    }
    
    /**
     Resets the ViewCoordinatable to use the view returned by `start()`
     */
    @discardableResult func reset() -> T {
        return coordinator.reset()
    }
}
