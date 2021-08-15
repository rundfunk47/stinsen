import Foundation
import SwiftUI

import Stinsen

class MainCoordinator: ViewCoordinatable {
    var children = ViewChild()
    
    enum Route: ViewRoute {
        case unauthenticated
        case authenticated
    }

    func resolveRoute(route: Route) -> AnyCoordinatable {
        switch route {
        case .unauthenticated:
            return AnyCoordinatable(
                NavigationViewCoordinator(
                    UnauthenticatedCoordinator()
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
