import Foundation
import SwiftUI
import Stinsen

final class ProfileCoordinator: NavigationCoordinatable {
    let stack = NavigationStack(initial: \ProfileCoordinator.start)
    
    @Route var start = makeStart
}
