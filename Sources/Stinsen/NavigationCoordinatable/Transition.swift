import Foundation
import SwiftUI

public enum Transition {
    case push(_ presentable: Presentable)
    case modal(_ presentable: Presentable)
    @available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    case fullScreen(_ presentable: Presentable)
    
    var presentable: Presentable {
        switch self {
        case .modal(let presentable):
            return presentable
        case .push(let presentable):
            return presentable
        case .fullScreen(let presentable):
            return presentable
        }
    }
}
