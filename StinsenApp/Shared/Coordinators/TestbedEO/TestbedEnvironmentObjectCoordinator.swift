import Foundation
import SwiftUI

import Stinsen

final class TestbedEnvironmentObjectCoordinator: NavigationCoordinatable {
    let stack = NavigationStack(initialRoute: \TestbedEnvironmentObjectCoordinator.start)
    
    func customize(_ view: AnyView) -> some View {
        return view
    }
    

    @Route var start = makeStart
    @Route(.modal) var modalScreen = makeModalScreen
    @Route(.push) var pushScreen = makePushScreen
    @Route(.modal) var modalCoordinator = makeModalCoordinator
    @Route(.push) var pushCoordinator = makePushCoordinator
}
