import Foundation
import Combine
import SwiftUI

struct NavigationRootItem {
    let keyPath: Int
    let input: Any?
    let child: Presentable
}

/// Wrapper around childCoordinators
/// Used so that you don't need to write @Published
public class NavigationRoot: ObservableObject {
    @Published var item: NavigationRootItem
    
    init(item: NavigationRootItem) {
        self.item = item
    }
}

/// Represents a stack of routes
public class NavigationStack<T: NavigationCoordinatable> {
    var poppedTo = PassthroughSubject<Int, Never>()
    let initialRoute: PartialKeyPath<T>
    let initialInput: Any?
    var root: NavigationRoot!
    
    @Published var value: [NavigationStackItem]
    
    public init(initialRoute: PartialKeyPath<T>, initialInput: Any? = nil) {
        self.value = []
        self.initialRoute = initialRoute
        self.initialInput = initialInput
        self.root = nil
    }
}

struct NavigationStackItem {
    let presentationType: PresentationType
    let presentable: Presentable
    let keyPath: Int
    let input: Any?
}
