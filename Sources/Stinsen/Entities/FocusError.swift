import Foundation

public enum FocusError: LocalizedError {
    case routeNotFound
    
    public var errorDescription: String {
        switch self {
        case .routeNotFound:
            return "Route not found"
        }
    }
}
