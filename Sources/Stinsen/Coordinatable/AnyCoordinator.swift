import Foundation
import SwiftUI

// MARK: - Abstract base class
fileprivate class _AnyCoordinatorBase: Coordinatable {
    func view() -> AnyView {
        fatalError("must override")
    }
    
    var parent: ChildDismissable? {
        get {
            fatalError("must override")
        } set {
            fatalError("must override")
        }
    }
    
    func dismissChild<T: Coordinatable>(coordinator: T, action: (() -> Void)?) {
        fatalError("must override")
    }
    
    var id: String {
        fatalError("must override")
    }
    
    init() {
        guard type(of: self) != _AnyCoordinatorBase.self else {
            fatalError("_AnyCoordinatorBase instances can not be created; create a subclass instance instead")
        }
    }
}

// MARK: - Box container class
fileprivate final class _AnyCoordinatorBox<Base: Coordinatable>: _AnyCoordinatorBase {
    var base: Base
    
    init(_ base: Base) { self.base = base }
    
    override func view() -> AnyView {
        self.base.view()
    }
    
    override var parent: ChildDismissable? {
        get {
            base.parent
        } set {
            base.parent = newValue
        }
    }
    
    override func dismissChild<T: Coordinatable>(coordinator: T, action: (() -> Void)?) {
        base.dismissChild(coordinator: coordinator, action: action)
    }
    
    override var id: String {
        base.id
    }
}

// MARK: - _AnyCoordinator Wrapper
public final class AnyCoordinator: Coordinatable {
    public var parent: ChildDismissable? {
        get {
            box.parent
        } set {
            box.parent = newValue
        }
    }
    
    public func dismissChild<T: Coordinatable>(coordinator: T, action: (() -> Void)?) {
        box.dismissChild(coordinator: coordinator, action: action)
    }
    
    public func view() -> AnyView {
        box.view()
    }
    
    public var id: String {
        box.id
    }

    private let box: _AnyCoordinatorBase

    public init<Base: Coordinatable>(_ base: Base) {
        box = _AnyCoordinatorBox(base)
    }
}
