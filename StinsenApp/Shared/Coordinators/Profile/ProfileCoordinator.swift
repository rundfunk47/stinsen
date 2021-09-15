import Foundation
import SwiftUI
import Stinsen

final class ProfileCoordinator: NavigationCoordinatable {
    let stack = NavigationStack(initialRoute: \ProfileCoordinator.start)
    
    @Route var start = makeStart
}
