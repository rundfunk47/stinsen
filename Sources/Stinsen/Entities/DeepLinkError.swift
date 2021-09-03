import Foundation

public enum DeepLinkError: LocalizedError {
    case unhandledDeepLink(deepLink: [Any])
    
    public var errorDescription: String? {
        switch self {
        case .unhandledDeepLink(let deepLink):
            return "Unhandled deep link: \(String(describing: deepLink))"
        }
    }
}
