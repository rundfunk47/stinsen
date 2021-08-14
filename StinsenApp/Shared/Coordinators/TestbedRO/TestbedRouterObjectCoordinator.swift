import Foundation
import SwiftUI

import Stinsen

class TestbedRouterObjectCoordinator: NavigationCoordinatable {
    var navigationStack: NavigationStack = NavigationStack()
    
    enum Route: NavigationRoute {
        case pushScreen
        case modalScreen
        case pushCoordinator
        case modalCoordinator
    }

    func resolveRoute(route: Route) -> Transition {
        switch route {
        case .modalCoordinator:
            return .modal(
                AnyCoordinatable(
                    NavigationViewCoordinatable(TestbedRouterObjectCoordinator())
                )
            )
        case .pushCoordinator:
            return .push(
                AnyCoordinatable(
                    TestbedRouterObjectCoordinator()
                )
            )
        case .pushScreen:
            return .push(
                AnyView(
                    TestbedRouterObjectScreen()
                        .navigationTitle(with: "Pushed testbed")
                )
            )
        case .modalScreen:
            return .modal(
                AnyView(
                    NavigationView {
                        TestbedRouterObjectScreen().navigationTitle(with: "Modal testbed")
                    }
                )
            )
        }
    }
    
    @ViewBuilder func start() -> some View {
        TestbedRouterObjectScreen()
            .navigationTitle(with: "Coordinator testbed")
    }
}
