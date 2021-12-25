import Foundation
import SwiftUI

protocol NavigationOutputable {
    func using(coordinator: Any, input: Any) -> ViewPresentable
}

public protocol RouteType {
    
}

public struct RootSwitch: RouteType {

}

public struct Presentation: RouteType {
    let type: PresentationType
}

public struct Transition<T: NavigationCoordinatable, U: RouteType, Input, Output: ViewPresentable>: NavigationOutputable {
    let type: U
    let closure: ((T) -> ((Input) -> Output))
    
    func using(coordinator: Any, input: Any) -> ViewPresentable {
        if Input.self == Void.self {
            return closure(coordinator as! T)(() as! Input)
        } else {
            return closure(coordinator as! T)(input as! Input)
        }
    }
}

@propertyWrapper public class NavigationRoute<T: NavigationCoordinatable, U: RouteType, Input, Output: ViewPresentable> {
    
    public var wrappedValue: Transition<T, U, Input, Output>
    
    init(standard: Transition<T, U, Input, Output>) {
        self.wrappedValue = standard
    }
}

extension NavigationRoute where T: NavigationCoordinatable, Input == Void , Output == AnyView , U == Presentation {
    public convenience init<ViewOutput: View>(wrappedValue: @escaping ((T) -> (() -> ViewOutput)), _ presentation: PresentationType) {
        self.init(standard: Transition(type: Presentation(type: presentation), closure: { coordinator in
            return { _ in AnyView(wrappedValue(coordinator)()) }
        }))
    }
}

extension NavigationRoute where T: NavigationCoordinatable, Output == AnyView, U == Presentation {
    public convenience init<ViewOutput: View>(wrappedValue: @escaping ((T) -> ((Input) -> ViewOutput)), _ presentation: PresentationType) {
        self.init(standard: Transition(type: Presentation(type: presentation) , closure: { coordinator in
            return { input in AnyView(wrappedValue(coordinator)(input)) }
        }))
    }
}

extension NavigationRoute where T: NavigationCoordinatable, Input == Void , Output: Coordinatable, U == Presentation {
    public convenience init(wrappedValue: @escaping ((T) -> (() -> Output)), _ presentation: PresentationType) {
        self.init(standard: Transition(type: Presentation(type: presentation), closure: { coordinator in
            return { _ in wrappedValue(coordinator)() }
        }))
    }
}

extension NavigationRoute where T: NavigationCoordinatable, Output: Coordinatable, U == Presentation {
    public convenience init(wrappedValue: @escaping ((T) -> ((Input) -> Output)), _ presentation: PresentationType) {
        self.init(standard: Transition(type: Presentation(type: presentation), closure: { coordinator in
            return { input in wrappedValue(coordinator)(input) }
        }))
    }
}

extension NavigationRoute where T: NavigationCoordinatable, Input == Void , Output == AnyView , U == RootSwitch {
    public convenience init<ViewOutput: View>(wrappedValue: @escaping ((T) -> (() -> ViewOutput))) {
        self.init(standard: Transition(type: RootSwitch(), closure: { coordinator in
            return { _ in AnyView(wrappedValue(coordinator)()) }
        }))
    }
}

extension NavigationRoute where T: NavigationCoordinatable, Output == AnyView, U == RootSwitch {
    public convenience init<ViewOutput: View>(wrappedValue: @escaping ((T) -> ((Input) -> ViewOutput))) {
        self.init(standard: Transition(type: RootSwitch() , closure: { coordinator in
            return { input in AnyView(wrappedValue(coordinator)(input)) }
        }))
    }
}

extension NavigationRoute where T: NavigationCoordinatable, Input == Void , Output: Coordinatable, U == RootSwitch {
    public convenience init(wrappedValue: @escaping ((T) -> (() -> Output))) {
        self.init(standard: Transition(type: RootSwitch(), closure: { coordinator in
            return { _ in wrappedValue(coordinator)() }
        }))
    }
}

extension NavigationRoute where T: NavigationCoordinatable, Output: Coordinatable, U == RootSwitch {
    public convenience init(wrappedValue: @escaping ((T) -> ((Input) -> Output))) {
        self.init(standard: Transition(type: RootSwitch(), closure: { coordinator in
            return { input in wrappedValue(coordinator)(input) }
        }))
    }
}
