import Foundation
import SwiftUI

import Stinsen

class HomeCoordinator: NavigationCoordinatable {
    let navigationStack: NavigationStack = NavigationStack<Route>()

    enum Route: NavigationRoute {

    }
    
    func resolveRoute(route: Route) -> Transition {

    }
    
    @ViewBuilder func start() -> some View {
        HomeScreen()
    }
}
