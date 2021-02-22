import Foundation
import SwiftUI

import Stinsen

class CreateProjectCoordinator: NavigationCoordinatable {
    var children = Children()
    var navigationStack: NavigationStack<Route> = NavigationStack()

    enum Route {

    }

    func resolveRoute(route: Route) -> Transition {

    }
    
    @ViewBuilder func start() -> some View {
        CreateProjectScreen()
    }
}
