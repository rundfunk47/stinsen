import Foundation
import SwiftUI

enum Presented {
    case modal(_: AnyView)
    case push(_: AnyView)
    
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
    
    var view: AnyView {
        switch self {
        case .modal(let view):
            return view
        case .push(let view):
            return view
        }
    }
}
