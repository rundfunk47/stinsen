import Foundation
import SwiftUI

import Stinsen

final class UnauthenticatedCoordinator: NavigationCoordinatable {
    lazy var navigationStack = NavigationStack(self)
    
    enum Route {
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
