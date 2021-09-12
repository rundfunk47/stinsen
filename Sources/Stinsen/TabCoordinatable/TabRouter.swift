import SwiftUI
import Foundation

public class TabRouter<T: TabCoordinatable>: Routable {
    fileprivate weak var coordinator: T!
    
    init(_ coordinator: T) {
        self.coordinator = coordinator
    }
}

public extension TabRouter {
    /**
     Searches the tabbar for the first route that matches the route and makes it the active tab.

     - Parameter route: The route that will be focused.
     */
    @discardableResult func focusFirst<Output: Coordinatable>(
        _ route: KeyPath<T, Content<T, Output>>
    ) -> Output {
        self.coordinator.focusFirst(route)
    }
    
    /**
     Searches the tabbar for the first route that matches the route and makes it the active tab.

     - Parameter route: The route that will be focused.
     */
    @discardableResult func focusFirst<Output: View>(
        _ route: KeyPath<T, Content<T, Output>>
    ) -> T {
        self.coordinator.focusFirst(route)
    }
}
