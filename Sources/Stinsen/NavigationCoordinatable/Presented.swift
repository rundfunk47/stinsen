import Foundation
import SwiftUI

enum Presented {
    case modal(_: AnyView)
    case push(_: AnyView)
    @available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    case fullScreen(_: AnyView)
    
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
    
    var view: AnyView {
        switch self {
        case .modal(let view):
            return view
        case .push(let view):
            return view
        case .fullScreen(let view):
            return view
        }
    }
}
