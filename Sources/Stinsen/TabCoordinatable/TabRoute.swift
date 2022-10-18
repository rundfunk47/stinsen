import Foundation
import SwiftUI

protocol Outputable {
    func using(coordinator: Any) -> ViewPresentable
    func tabItem(active: Bool, coordinator: Any) -> AnyView
    func onTapped(_ isRepeat: Bool, coordinator: Any)
}

public class Content<T: TabCoordinatable, Output: ViewPresentable>: Outputable {
    
    func tabItem(active: Bool, coordinator: Any) -> AnyView {
        return self.tabItem(coordinator as! T)(active)
    }
    
    func using(coordinator: Any) -> ViewPresentable {
        let closureOutput = self.closure(coordinator as! T)()
        self.output = closureOutput
        return closureOutput
    }
    
    func onTapped(_ isRepeat: Bool, coordinator: Any) {
        self.onTapped(coordinator as! T)(isRepeat, output!)
    }
    
    let closure: ((T) -> (() -> Output))
    let tabItem: ((T) -> ((Bool) -> AnyView))
    let onTapped: ((T) -> ((Bool, Output) -> Void))
    
    private var output: Output?
    
    init<TabItem: View>(
        closure: @escaping ((T) -> (() -> Output)),
        tabItem: @escaping ((T) -> ((Bool) -> TabItem)),
        onTapped: @escaping ((T) -> ((Bool, Output) -> Void))
    ) {
        self.closure = closure
        self.tabItem = { coordinator in
            return {
                AnyView(tabItem(coordinator)($0))
            }
        }
        self.onTapped = { coordinator in
            onTapped(coordinator)
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
                tabItem: tabItem,
                onTapped: { _ in { _, _ in }}
            )
        )
    }
    
    public convenience init<ViewOutput: View, TabItem: View>(
        wrappedValue: @escaping ((T) -> (() -> ViewOutput)),
        tabItem: @escaping ((T) -> ((Bool) -> TabItem)),
        onTapped: @escaping ((T) -> ((Bool, Output) -> Void))
    ) {
        self.init(standard: Content(
            closure: { coordinator in { AnyView(wrappedValue(coordinator)()) }},
            tabItem: tabItem,
            onTapped: onTapped))
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
                tabItem: tabItem,
                onTapped: { _ in { _, _ in }}
            )
        )
    }
    
    public convenience init<TabItem: View>(
        wrappedValue: @escaping ((T) -> (() -> Output)),
        tabItem: @escaping ((T) -> ((Bool) -> TabItem)),
        onTapped: @escaping ((T) -> ((Bool, Output) -> Void))
    ) {
        self.init(standard: Content(
            closure: { coordinator in { wrappedValue(coordinator)() }},
            tabItem: tabItem,
            onTapped: onTapped))
    }
}
