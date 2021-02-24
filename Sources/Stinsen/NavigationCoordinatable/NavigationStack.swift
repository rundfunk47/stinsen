import Foundation
import Combine

enum Presentation<Route> {
    case modal(_ : Route)
    case push(_ : Route)
    
    var route: Route {
        switch self {
        case .modal(let route):
            return route
        case .push(let route):
            return route
        }
    }
}

/// Represents a stack of views
public class NavigationStack<Route>: AppearingMetadata, ObservableObject {
    public var appearing: Int?
    public var poppedTo = PassthroughSubject<Int, Never>()

    @Published private (set) var value: [Presentation<Route>]
    
    public init() {
        self.value = []
    }
    
    public func popTo(_ int: Int) {
        value = Array(value.prefix(int + 1))
        poppedTo.send(int)
    }
    
    func append(_ route: Presentation<Route>) {
        self.value.append(route)
    }
}

public protocol AppearingMetadata {
    // Helper variable to keep track of which view with ID that is appearing. SwiftUI has no easy way of knowing when the user presses the back button, so the way we know the user is popping the stack is that the appearing ID is less than the stack count.
    var appearing: Int? { get set }
    func popTo(_ int: Int)
}
