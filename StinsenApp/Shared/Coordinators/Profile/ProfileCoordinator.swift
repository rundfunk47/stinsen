import Foundation
import SwiftUI
import Stinsen

final class ProfileCoordinator: NavigationCoordinatable {
    let stack = NavigationStack(initial: \ProfileCoordinator.start)
    
    @Root var start = makeStart
}
