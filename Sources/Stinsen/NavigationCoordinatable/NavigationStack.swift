import Foundation

/// Represents a stack of views
public class NavigationStack<Route>: ObservableObject {
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
    
    @Published var value: [Presentation<Route>]
    
    public init() {
        self.value = []
    }
}
