import Foundation

public protocol ChildDismissable: AnyObject {
    func dismissChild<T: Coordinatable>(coordinator: T, action: (() -> Void)?)
}
