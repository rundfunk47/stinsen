import Foundation
import SwiftUI

import Stinsen

class UnauthenticatedCoordinator: NavigationCoordinatable {
    var navigationStack = NavigationStack()
    
    enum Route: NavigationRoute {
        case forgotPassword
    }

    func resolveRoute(route: Route) -> Transition {
        switch route {
        case .forgotPassword:
            return .push(AnyView(ForgotPasswordScreen()))
        }
    }
    
    @ViewBuilder func start() -> some View {
        LoginScreen()
    }
    
    init() {

    }
}
