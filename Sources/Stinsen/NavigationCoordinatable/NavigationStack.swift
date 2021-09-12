import Foundation
import Combine
import SwiftUI

/// Represents a stack of routes
public class NavigationStack {
    var poppedTo = PassthroughSubject<Int, Never>()
    
    @Published var value: [NavigationStackItem]
    
    public init() {
        self.value = []
    }
}

struct NavigationStackItem {
    let presentationType: PresentationType
    let presentable: Presentable
    let keyPath: Int
    let input: Any?
}
