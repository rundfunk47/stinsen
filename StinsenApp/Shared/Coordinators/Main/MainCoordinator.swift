import Foundation
import SwiftUI

import Stinsen

class MainCoordinator: RootCoordinatable {    
    var children = Children()

    enum Route {
        case unauthenticated
        case authenticated
    }

    func resolveRoute(route: Route) -> AnyCoordinatable {
        switch route {
        case .unauthenticated:
            return AnyCoordinatable(
                NavigationViewCoordinatable(
                    childCoordinator: UnauthenticatedCoordinator()
                )
            )
        case .authenticated:
            return AnyCoordinatable(
                AuthenticatedCoordinator()
            )
        }
    }
    
    @ViewBuilder func start() -> some View {
        LoadingScreen()
    }
    
    init() {
        
    }
}
