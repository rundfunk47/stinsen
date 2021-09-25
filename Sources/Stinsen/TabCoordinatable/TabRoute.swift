import Foundation
import SwiftUI

protocol Outputable {
    func using(coordinator: Any) -> ViewPresentable
    func tabItem(active: Bool, coordinator: Any) -> AnyView
}

public struct Content<T: TabCoordinatable, Output: ViewPresentable>: Outputable {
    func tabItem(active: Bool, coordinator: Any) -> AnyView {
        return self.tabItem(coordinator as! T)(active)
    }
    
    func using(coordinator: Any) -> ViewPresentable {
        return self.closure(coordinator as! T)()
    }
    
    let closure: ((T) -> (() -> Output))
    let tabItem: ((T) -> ((Bool) -> AnyView))
    
    init<TabItem: View>(
        closure: @escaping ((T) -> (() -> Output)),
        tabItem: @escaping ((T) -> ((Bool) -> TabItem))
    ) {
        self.closure = closure
        self.tabItem = { coordinator in
            return {
                AnyView(tabItem(coordinator)($0))
            }
        }
    }
}

@propertyWrapper public class TabRoute<T: TabCoordinatable, Output: ViewPresentable> {
    public var wrappedValue: Content<T, Output>
    
    fileprivate init(standard: Content<T, Output>) {
        self.wrappedValue = standard
    }
}

extension TabRoute where T: TabCoordinatable, Output == AnyView {
    public convenience init<ViewOutput: View, TabItem: View>(
        wrappedValue: @escaping ((T) -> (() -> ViewOutput)),
        tabItem: @escaping ((T) -> ((Bool) -> TabItem))
    ) {
        self.init(
            standard: Content(
                closure: { coordinator in { AnyView(wrappedValue(coordinator)()) }},
                tabItem: tabItem
            )
        )
    }
}

extension TabRoute where T: TabCoordinatable, Output: Coordinatable {
    public convenience init<TabItem: View>(
        wrappedValue: @escaping ((T) -> (() -> Output)),
        tabItem: @escaping ((T) -> ((Bool) -> TabItem))
    ) {
        self.init(
            standard: Content(
                closure: { coordinator in { wrappedValue(coordinator)() }},
                tabItem: tabItem
            )
        )
    }
}
