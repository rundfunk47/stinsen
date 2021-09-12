import Foundation
import SwiftUI

/// The TabCoordinatable is used to represent a coordinator with a TabView
public protocol TabCoordinatable: Coordinatable {
    typealias Route = TabRoute
    typealias Router = TabRouter<Self>

    var child: TabChild { get }

    associatedtype CustomizeViewType: View

    /**
     Implement this function if you wish to customize the view on all views and child coordinators, for instance, if you wish to change the `tintColor` or inject an `EnvironmentObject`.

     - Parameter view: The input view.

     - Returns: The modified view.
     */
    func customize(_ view: AnyView) -> CustomizeViewType

    /**
     Searches the tabbar for the first route that matches the route and makes it the active tab.

     - Parameter route: The route that will be focused.
     */
    @discardableResult func focusFirst<Output: Coordinatable>(
        _ route: KeyPath<Self, Content<Self, Output>>
    ) -> Output
    
    /**
     Searches the tabbar for the first route that matches the route and makes it the active tab.

     - Parameter route: The route that will be focused.
     */
    @discardableResult func focusFirst<Output: View>(
        _ route: KeyPath<Self, Content<Self, Output>>
    ) -> Self
}

public extension TabCoordinatable {
    func customize(_ view: AnyView) -> some View {
        return view
    }

    func view() -> AnyView {
        AnyView(
            TabCoordinatableView(
                paths: self.child.startingItems,
                coordinator: self,
                customize: customize
            )
        )
    }
    
    @discardableResult func focusFirst<Output: Coordinatable>(
        _ route: KeyPath<Self, Content<Self, Output>>
    ) -> Output {
        guard let value = child.allItems.enumerated().first(where: { item in
            guard item.element.keyPathIsEqual(route) else {
                return false
            }
            
            return true
        }) else {
            fatalError()
        }
        
        self.child.activeTab = value.offset
        
        return value.element.presentable as! Output
    }
    
    @discardableResult func focusFirst<Output: View>(
        _ route: KeyPath<Self, Content<Self, Output>>
    ) -> Self {
        guard let value = child.allItems.enumerated().first(where: { item in
            guard item.element.keyPathIsEqual(route) else {
                return false
            }
            
            return true
        }) else {
            fatalError()
        }
        
        self.child.activeTab = value.offset
        
        return self
    }
}
