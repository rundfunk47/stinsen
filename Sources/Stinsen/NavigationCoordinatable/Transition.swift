import Foundation
import SwiftUI

public enum Transition {
    case push(_ presentable: Presentable)
    case modal(_ presentable: Presentable)
    
    var presentable: Presentable {
        switch self {
        case .modal(let presentable):
            return presentable
        case .push(let presentable):
            return presentable
        }
    }
}
