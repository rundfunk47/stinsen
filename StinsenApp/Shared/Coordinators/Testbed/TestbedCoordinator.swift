import Foundation
import SwiftUI

import Stinsen

class TestbedCoordinator: NavigationCoordinatable {
    var navigationStack: NavigationStack = NavigationStack()
    
    enum Route {
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
                        .navigationBarTitle("Pushed testbed")
                )
            )
        case .modalScreen:
            return .modal(
                AnyView(
                    TestbedScreen()
                        .navigationBarTitle("Modal testbed")
                )
            )
        }
    }
    
    @ViewBuilder func start() -> some View {
        TestbedScreen()
            .navigationBarTitle("Coordinator testbed")
    }
}
