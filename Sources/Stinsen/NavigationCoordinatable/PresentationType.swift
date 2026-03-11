import Foundation
import SwiftUI

public enum PresentationType {
    case modal
    case modalNonDismissible
    case push
    @available(iOS 14, tvOS 14, watchOS 7, *)
    case fullScreen
    
    /// Creates a modal presentation type with configurable dismiss behavior.
    /// - Parameter dismissible: Whether the modal can be dismissed by drag gesture. Defaults to `true`.
    /// - Returns: `.modal` if dismissible, `.modalNonDismissible` if not.
    public static func modal(dismissible: Bool) -> PresentationType {
        dismissible ? .modal : .modalNonDismissible
    }

    var isModal: Bool {
        switch self {
        case .modal, .modalNonDismissible:
            return true
        default:
            return false
        }
    }
    
    var isModalDismissible: Bool {
        switch self {
        case .modal:
            return true
        case .modalNonDismissible:
            return false
        default:
            return true
        }
    }

    var isPush: Bool {
        switch self {
        case .push:
            return true
        default:
            return false
        }
    }
    
    @available(iOS 14, tvOS 14, watchOS 7, *)
    var isFullScreen: Bool {
        switch self {
        case .fullScreen:
            return true
        default:
            return false
        }
    }
}
