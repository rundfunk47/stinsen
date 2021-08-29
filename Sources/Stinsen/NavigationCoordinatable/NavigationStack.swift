import Foundation
import Combine

/// Represents a stack of routes
public final class NavigationStack<Route: NavigationRoute>: ObservableObject {
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
    public weak var resolver: AnyNavigationResolver! {
        didSet {
            if oldValue == nil {
                let values = startup.map { route in
                    (route: route, resolver.anyResolveRoute(route: route))
                }
                
                self.value = values
            }
        }
    }
    
    @Published private (set) var value: [(route: Route, transition: Transition)]

    var startup: [Route]
    var ready: Bool = false
    
    public init(_ startup: [Route] = []) {
        self.startup = startup
        self.value = []
        self.dismissalAction = nil
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
    
    func append(_ route: Route) {
        let transition = self.resolver.anyResolveRoute(route: route)
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
