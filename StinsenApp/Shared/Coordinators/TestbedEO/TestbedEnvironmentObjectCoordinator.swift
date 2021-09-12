import Foundation
import SwiftUI

import Stinsen

final class TestbedEnvironmentObjectCoordinator: NavigationCoordinatable {
    var stack: NavigationStack = NavigationStack()
    
    @Route(.modal) var modalScreen = makeModalScreen
    @Route(.push) var pushScreen = makePushScreen
    @Route(.modal) var modalCoordinator = makeModalCoordinator
    @Route(.push) var pushCoordinator = makePushCoordinator
}
