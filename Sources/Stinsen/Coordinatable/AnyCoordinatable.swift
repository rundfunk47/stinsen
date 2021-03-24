import Foundation
import Combine
import SwiftUI

// MARK: - Abstract base class
fileprivate class _AnyCoordinatableBase: Coordinatable {
    func dismissChildCoordinator(_ childCoordinator: AnyCoordinatable, _ completion: (() -> Void)?) {
        fatalError("override me")
    }
    
    func coordinatorView() -> AnyView {
        fatalError("override me")
    }
    
    var childCoordinators: [AnyCoordinatable] {
        fatalError("override me")
    }
    
    var objectWillChange: ObservableObjectPublisher {
        fatalError("override me")
    }
    
    init() {
        guard type(of: self) != _AnyCoordinatableBase.self else {
            fatalError("_AnyCoordinatableBase<T> instances can not be created; create a subclass instance instead")
        }
    }
    
    var id: String {
        fatalError("override me")
    }
    
    var dismissalAction: DismissalAction {
        get {
            fatalError("override me")
        } set {
            fatalError("override me")
        }
    }
}

// MARK: - Box container class
fileprivate final class _AnyCoordinatableBox<Base: Coordinatable>: _AnyCoordinatableBase {
    var base: Base
    init(_ base: Base) { self.base = base }
    
    override var objectWillChange: ObservableObjectPublisher {
        return base.objectWillChange as! ObservableObjectPublisher
    }
    
    override func coordinatorView() -> AnyView {
        return base.coordinatorView()
    }
    
    override var childCoordinators: [AnyCoordinatable] {
        return base.childCoordinators
    }
    
    override func dismissChildCoordinator(_ childCoordinator: AnyCoordinatable, _ completion: (() -> Void)?) {
        base.dismissChildCoordinator(childCoordinator, completion)
    }
    
    override var id: String {
        return base.id
    }
    
    override var dismissalAction: DismissalAction {
        get {
            return base.dismissalAction
        } set {
            base.dismissalAction = newValue
        }
    }
}

// MARK: - AnyCoordinatable Wrapper
public final class AnyCoordinatable: Coordinatable {
    private let box: _AnyCoordinatableBase
    private let _childCoordinators: () -> [AnyCoordinatable]
    private let _getDismissalAction: () -> DismissalAction
    private let _setDismissalAction: (@escaping DismissalAction) -> Void
    
    public init<Base: Coordinatable>(_ base: Base) {
        box = _AnyCoordinatableBox(base)
        _childCoordinators = { base.childCoordinators }
        _getDismissalAction = { base.dismissalAction }
        _setDismissalAction = { action in
            base.dismissalAction = action
        }
    }

    public func coordinatorView() -> AnyView {
        return box.coordinatorView()
    }
    
    public var objectWillChange: ObservableObjectPublisher {
        get {
            return box.objectWillChange
        }
    }
    
    public var id: String {
        get {
            return box.id
        }
    }
    
    public var childCoordinators: [AnyCoordinatable] {
        get {
            _childCoordinators()
        }
    }
    
    public func dismissChildCoordinator(_ childCoordinator: AnyCoordinatable, _ completion: (() -> Void)?) {
        box.dismissChildCoordinator(childCoordinator, completion)
    }
    
    public var dismissalAction: DismissalAction {
        get {
            _getDismissalAction()
        } set {
            _setDismissalAction(newValue)
        }
    }
}

public extension Coordinatable {
    func eraseToAnyCoordinatable() -> AnyCoordinatable {
        return AnyCoordinatable(self)
    }
}
