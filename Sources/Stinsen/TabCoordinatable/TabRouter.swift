import Foundation

public class TabRouter<T>: Routable {
    var _anyFocus: ((Any) -> Bool) throws -> Void

    /**
     Searches the selectable tabs for the first route that matches the closure. If found, will make that tab the active one.

     - Parameter predicate: A closure that takes an element of the sequence as
     its argument and returns a Boolean value indicating whether the
     element is a match.
     
     - Throws: `FocusError.routeNotFound`
               if the route was not found.
     */
    public func focus(where predicate: (T) -> Bool) throws {
        try _anyFocus({
            return predicate($0 as! T)
        })
    }
    
    init<U: TabCoordinatable>(_ coordinator: U) where U.Route == T {
        self._anyFocus = { closure in
            try coordinator.children.focus(where: closure)
        }
    }
}

extension TabRouter where T: Equatable {
    /**
     Searches the selectable tabs for the first route that is equal to the route provided. If found, will make that tab the active one.
     
     - Parameter route: The route to look for.
     
     - Throws: `FocusError.routeNotFound`
               if the route was not found.
     */
    public func focus(_ route: T) throws {
        try self.focus(where: { $0 == route })
    }
}
