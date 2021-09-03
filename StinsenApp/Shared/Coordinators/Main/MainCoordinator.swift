import Foundation
import SwiftUI

import Stinsen

final class MainCoordinator: ViewCoordinatable {
    lazy var children = ViewChild(self)
    
    enum Route {
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
