import Foundation

// see https://swiftrocks.com/weak-dictionary-values-in-swift
final class WeakRef<T: AnyObject> {
    weak var value: T?
    
    init(value: T) {
        self.value = value
    }
}
