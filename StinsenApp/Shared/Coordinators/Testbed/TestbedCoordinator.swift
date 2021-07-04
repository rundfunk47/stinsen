import Foundation
import SwiftUI

import Stinsen

class TestbedCoordinator: NavigationCoordinatable {
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
                    NavigationViewCoordinatable(TestbedCoordinator())
                )
            )
        case .pushCoordinator:
            return .push(
                AnyCoordinatable(
                    TestbedCoordinator()
                )
            )
        case .pushScreen:
            return .push(
                AnyView(
                    TestbedScreen()
                        .navigationTitle(with: "Pushed testbed")
                )
            )
        case .modalScreen:
            return .modal(
                AnyView(
                    NavigationView {
                        TestbedScreen().navigationTitle(with: "Modal testbed")
                    }
                )
            )
        }
    }
    
    @ViewBuilder func start() -> some View {
        TestbedScreen()
            .navigationTitle(with: "Coordinator testbed")
    }
}
