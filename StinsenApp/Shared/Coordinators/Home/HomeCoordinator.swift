import Foundation
import SwiftUI

import Stinsen

class HomeCoordinator: NavigationCoordinatable {
    var navigationStack: NavigationStack = NavigationStack()

    enum Route {

    }
    
    func resolveRoute(route: Route) -> Transition {

    }
    
    @ViewBuilder func start() -> some View {
        HomeScreen()
    }
}
