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
        @available(iOS 14.0, watchOS 7.0, tvOS 14.0, *)
        case coverScreen
        @available(iOS 14.0, watchOS 7.0, tvOS 14.0, *)
        case coverCoordinator
    }

    func resolveRoute(route: Route) -> Transition {
        switch route {
        case .modalCoordinator:
            return .modal(
                AnyCoordinatable(
                    NavigationViewCoordinator(TestbedEnvironmentObjectCoordinator())
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
        case .coverScreen:
            if #available(iOS 14.0, watchOS 7.0, tvOS 14.0, *) {
                return .fullScreen(
                    AnyView(
                        NavigationView {
                            TestbedEnvironmentObjectScreen().navigationTitle(with: "Cover testbed")
                        }
                    )
                )
            } else {
                fatalError()
            }
        case .coverCoordinator:
            if #available(iOS 14.0, watchOS 7.0, tvOS 14.0, *) {
                return .fullScreen(
                    AnyCoordinatable(
                        NavigationViewCoordinator(TestbedEnvironmentObjectCoordinator())
                    )
                )
            } else {
                fatalError()
            }
        }
    }
    
    @ViewBuilder func start() -> some View {
        TestbedEnvironmentObjectScreen()
            .navigationTitle(with: "Coordinator testbed")
    }
}
