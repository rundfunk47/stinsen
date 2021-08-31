import Foundation

class TabRoutable {
    var _anyFocus: ((TabRoute) -> Bool) throws -> Void
    
    func anyFocus(where closure: (TabRoute) -> Bool) throws {
        try _anyFocus(closure)
    }
    
    init<T: TabCoordinatable>(coordinator: T) {
        _anyFocus = { closure in
            try coordinator.children.focus(where: closure)
        }
    }
}
