import Foundation
import SwiftUI

public struct Transition<T: NavigationCoordinatable, Input, Output: Presentable> {
    let presentation: PresentationType
    let closure: ((T) -> ((Input) -> Output))
}

@propertyWrapper public class NavigationRoute<T: NavigationCoordinatable, Input, Output: Presentable> {
    public var wrappedValue: Transition<T, Input, Output>
    
    init(standard: Transition<T, Input, Output>) {
        self.wrappedValue = standard
    }
}

extension NavigationRoute where T: NavigationCoordinatable, Input == Void , Output == AnyView {
    public convenience init<ViewOutput: View>(wrappedValue: @escaping ((T) -> (() -> ViewOutput)), _ presentation: PresentationType) {
        self.init(standard: Transition(presentation: presentation, closure: { coordinator in
            return { _ in AnyView(wrappedValue(coordinator)()) }
        }))
    }
}

extension NavigationRoute where T: NavigationCoordinatable, Output == AnyView {
    public convenience init<ViewOutput: View>(wrappedValue: @escaping ((T) -> ((Input) -> ViewOutput)), _ presentation: PresentationType) {
        self.init(standard: Transition(presentation: presentation, closure: { coordinator in
            return { input in AnyView(wrappedValue(coordinator)(input)) }
        }))
    }
}

extension NavigationRoute where T: NavigationCoordinatable, Input == Void , Output: Coordinatable {
    public convenience init(wrappedValue: @escaping ((T) -> (() -> Output)), _ presentation: PresentationType) {
        self.init(standard: Transition(presentation: presentation, closure: { coordinator in
            return { _ in wrappedValue(coordinator)() }
        }))
    }
}

extension NavigationRoute where T: NavigationCoordinatable, Output: Coordinatable {
    public convenience init(wrappedValue: @escaping ((T) -> ((Input) -> Output)), _ presentation: PresentationType) {
        self.init(standard: Transition(presentation: presentation, closure: { coordinator in
            return { input in wrappedValue(coordinator)(input) }
        }))
    }
}
