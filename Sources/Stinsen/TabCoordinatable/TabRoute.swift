import Foundation


public protocol TabRoute {
    // Hack to work around the fact that TabRoute cannot be marked as Equatable directly
    func isEqual(to: TabRoute) -> Bool
}

public extension TabRoute where Self: Equatable {
    func isEqual(to: TabRoute) -> Bool {
        return self == (to as? Self)
    }
}
