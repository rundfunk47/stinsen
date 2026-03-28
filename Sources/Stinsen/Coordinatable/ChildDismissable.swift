import Foundation

public protocol ChildDismissable: AnyObject {
    func dismissChild<T: Coordinatable>(coordinator: T, action: (() -> Void)?)
    var canDismissChild: Bool { get }
}

public extension ChildDismissable {
    var canDismissChild: Bool { true }
}
