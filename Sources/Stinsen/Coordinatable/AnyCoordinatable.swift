import Foundation
import Combine
import SwiftUI

// MARK: - Abstract base class
fileprivate class _AnyCoordinatableBase: Coordinatable {
    func coordinatorView() -> AnyView {
        fatalError("override me")
    }
    
    var children: Children {
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
    
    var appearingMetadata: AppearingMetadata? {
        fatalError("override me")
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
    
    override var children: Children {
        return base.children
    }
    
    override var id: String {
        return base.id
    }
    
    override var appearingMetadata: AppearingMetadata? {
        get {
            return base.appearingMetadata
        }
    }
}

// MARK: - AnyCoordinatable Wrapper
public final class AnyCoordinatable: Coordinatable {
    private let box: _AnyCoordinatableBase
    private let _children: () -> Children
    private let _getAppearingMetadata: () -> AppearingMetadata?
    
    public init<Base: Coordinatable>(_ base: Base) {
        box = _AnyCoordinatableBox(base)
        _children = { base.children }
        _getAppearingMetadata = { base.appearingMetadata }
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
    
    public var children: Children {
        get {
            _children()
        }
    }
    
    public var appearingMetadata: AppearingMetadata? {
        get {
            _getAppearingMetadata()
        }
    }
}

public extension Coordinatable {
    func eraseToAnyCoordinatable() -> AnyCoordinatable {
        return AnyCoordinatable(self)
    }
}

