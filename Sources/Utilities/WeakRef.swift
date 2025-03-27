import Foundation

// see https://swiftrocks.com/weak-dictionary-values-in-swift
final class WeakRef<T: AnyObject>: Equatable {
    static func == (lhs: WeakRef<T>, rhs: WeakRef<T>) -> Bool {
        lhs.value === rhs.value
    }

    weak var value: T?
    
    init(value: T) {
        self.value = value
    }

    private init() {
        self.value = nil
    }
}

extension WeakRef {
    static var empty: WeakRef<T> {
        WeakRef()
    }
}
