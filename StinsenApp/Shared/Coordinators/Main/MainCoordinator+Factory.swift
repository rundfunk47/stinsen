import Foundation
import SwiftUI
import Stinsen

extension MainCoordinator {
    func makeUnauthenticated() -> NavigationViewCoordinator<UnauthenticatedCoordinator> {
        return NavigationViewCoordinator(UnauthenticatedCoordinator())
    }
    
    func makeAuthenticated(user: User) -> AuthenticatedCoordinator {
        return AuthenticatedCoordinator(user: user)
    }
}
