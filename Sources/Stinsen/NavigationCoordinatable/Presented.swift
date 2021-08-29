import Foundation
import SwiftUI

struct Presented {
    let view: AnyView
    let type: PresentationType
}

enum PresentationType {
    case modal
    case push
    case fullScreen
    
    var isModal: Bool {
        switch self {
        case .modal:
            return true
        default:
            return false
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
    
    var isFullScreen: Bool {
        switch self {
        case .fullScreen:
            return true
        default:
            return false
        }
    }
}
