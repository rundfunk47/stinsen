import Foundation

@propertyWrapper public class ViewRoute<T: ViewCoordinatable, Input, Output: Presentable> {
    public var wrappedValue: ((T) -> ((Input) -> Output))
    
    fileprivate init(standard: (@escaping (T) -> ((Input) -> Output))) {
        self.wrappedValue = standard
    }
}

extension ViewRoute where T: ViewCoordinatable {
    public convenience init(wrappedValue: (@escaping (T) -> ((Input) -> Output))) {
        self.init(standard: wrappedValue)
    }
}

extension ViewRoute where T: ViewCoordinatable, Input == Void, Output: Coordinatable {
    public convenience init(wrappedValue: @escaping ((T) -> (() -> Output))) {
        self.init(standard: { keyPath in
            return { _ in wrappedValue(keyPath)() }
        })
    }
}
