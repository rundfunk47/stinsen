import Foundation
import SwiftUI

/// A presentable is something that can presented as a view. It can either be a view (AnyView) or a coordinator (AnyCoordinatable)
public protocol Presentable {
    
}

extension AnyCoordinatable: Presentable {
    
}

extension AnyView: Presentable {
    
}
