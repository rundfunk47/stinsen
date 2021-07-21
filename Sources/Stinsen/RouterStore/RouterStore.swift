//
//  RouterStore.swift
//  Stinsen
//
//  Created by Moser Simon on 20.07.21.
//

import Foundation


@propertyWrapper public struct RouterObject<Value> {
    let routerId: String
    private var storage: RouterStore = RouterStore.shared

    public var wrappedValue: Value? {
        get { storage.router[routerId]?.value as? Value }
        set { storage.router[routerId]?.value = newValue as AnyObject }
    }
    
    public init(routerId: String) {
        self.routerId = routerId
    }
}

public class RouterStore {
    public static let shared = RouterStore()
    
    
    final class WeakRef {
        weak var value: AnyObject?
    }

    // a dictionary of weak references (https://swiftrocks.com/weak-dictionary-values-in-swift)
    var router = [String: WeakRef]()
}

// NavigationRouter
public extension RouterStore {
    func store<T>(id: String, router: NavigationRouter<T>) {
        let ref = WeakRef()
        ref.value = router
        self.router[id] = ref
    }
    
    func retrieve<T>(id: String) -> NavigationRouter<T>? {
        router[id]?.value as? NavigationRouter<T>
    }
}

// NavigationRouter
public extension RouterStore {
    func store<T>(id: String, router: ViewRouter<T>) {
        let ref = WeakRef()
        ref.value = router
        self.router[id] = ref
    }
    
    func retrieve<T>(id: String) -> ViewRouter<T>? {
        router[id]?.value as? ViewRouter<T>
    }
}

// TabRouter
public extension RouterStore {
    func store<T>(id: String, router: TabRouter<T>) {
        let ref = WeakRef()
        ref.value = router
        self.router[id] = ref
    }
    
    func retrieve<T>(id: String) -> TabRouter<T>? {
        router[id]?.value as? TabRouter<T>
    }
}
