import Foundation

public protocol StringIdentifiable {
    /// This function is used internally for Stinsen. Do not implement this directly in a coordinator, it will use the a standard implementation derived from the coordinatable you're implementing. The ID for the coordinator. Will not be unique across instances of the coordinator.
    var id: String { get }
}
