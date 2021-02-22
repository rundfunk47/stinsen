import Foundation

/// Represents a stack of views
public class NavigationStack<Route>: ObservableObject {
    @Published var value: [Route]
    
    public init() {
        self.value = []
    }
}
