import Foundation

@propertyWrapper public struct RouterObject<Value: Routable> {
    private var storage: RouterStore
    private var retreived: Value?
    
    public var wrappedValue: Value? {
        mutating get {
            guard let currentValue: Value = self.retreived else {
                self.retreived = storage.retrieve()
                return self.retreived
            }
            return currentValue
        }
        @available(*, unavailable, message: "RouterObject cannot be set") set {
            fatalError()
        }
    }
    
    public init() {
        self.storage = RouterStore.shared
    }
}

public class RouterStore {
    public static let shared = RouterStore()
    
    // an array of weak references
    private var routers = [WeakRef<AnyObject>]()
}

public extension RouterStore {
    func store<T: Routable>(router: T) {
        cleanupRouterStore()
        let ref = WeakRef<AnyObject>(value: router)
        self.routers.insert(ref, at: 0)
    }
    
    func retrieve<T: Routable>() -> T? {
        for router in self.routers {
            if let foundRouter = router.value as? T, router.value != nil {
                return foundRouter
            }
        }
        
        return nil
    }
    
    /// Removes all nil weak references
    private func cleanupRouterStore() {
        let notNilRouters = self.routers.filter({ $0.value != nil })
        self.routers = notNilRouters
    }
}
