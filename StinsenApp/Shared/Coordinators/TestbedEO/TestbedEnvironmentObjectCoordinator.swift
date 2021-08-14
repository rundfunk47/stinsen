import Foundation
import SwiftUI

import Stinsen

class TestbedEnvironmentObjectCoordinator: NavigationCoordinatable {
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
                    NavigationViewCoordinatable(TestbedEnvironmentObjectCoordinator())
                )
            )
        case .pushCoordinator:
            return .push(
                AnyCoordinatable(
                    TestbedEnvironmentObjectCoordinator()
                )
            )
        case .pushScreen:
            return .push(
                AnyView(
                    TestbedEnvironmentObjectScreen()
                        .navigationTitle(with: "Pushed testbed")
                )
            )
        case .modalScreen:
            return .modal(
                AnyView(
                    NavigationView {
                        TestbedEnvironmentObjectScreen().navigationTitle(with: "Modal testbed")
                    }
                )
            )
        }
    }
    
    @ViewBuilder func start() -> some View {
        TestbedEnvironmentObjectScreen()
            .navigationTitle(with: "Coordinator testbed")
    }
}
