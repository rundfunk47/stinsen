import Foundation
import Combine

struct ViewChildItem {
    let keyPath: Int
    let input: Any?
    let child: Presentable
}

/// Wrapper around childCoordinators
/// Used so that you don't need to write @Published
public class ViewChild: ObservableObject {
    @Published var item: ViewChildItem?
    
    public init() {
        self.item = nil
    }
}
