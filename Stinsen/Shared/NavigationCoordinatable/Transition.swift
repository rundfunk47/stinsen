import Foundation
import SwiftUI

public enum Transition {
    case push(_ presentable: Presentable)
    case modal(_ presentable: Presentable)
}
