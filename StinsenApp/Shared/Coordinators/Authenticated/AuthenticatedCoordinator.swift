import Foundation
import SwiftUI

import Stinsen

final class AuthenticatedCoordinator: TabCoordinatable {
    let children = TabChild<Route>([.home, .projects, .profile, .testbedEO, .testbedRO])
    
    enum Route: TabRoute {
        case home
        case projects
        case profile
        case testbedEO
        case testbedRO
    }
    
    private func imageName(forRoute route: Route) -> String {
        let baseImageName: String
        switch route {
        case .home:
            baseImageName = "house"
        case .projects:
            baseImageName = "doc.text"
        case .profile:
            baseImageName = "person"
        case .testbedEO:
            baseImageName = "bed.double"
        case .testbedRO:
            baseImageName = "bed.double"
        }
        
        if route == children.activeRoute {
            return "\(baseImageName).fill"
        } else {
            return baseImageName
        }
    }
    
    @ViewBuilder func tabItem(forRoute route: Route) -> some View {
        Image(systemName: imageName(forRoute: route))
        switch route {
        case .home:
            Text("Home")
        case .projects:
            Text("Projects")
        case .profile:
            Text("Profile")
        case .testbedEO:
            Text("Testbed (EO)")
        case .testbedRO:
            Text("Testbed (RO)")
        }
    }
    
    func resolveRoute(route: Route) -> AnyCoordinatable {
        switch route {
        case .home:
            return NavigationViewCoordinator(HomeCoordinator()).eraseToAnyCoordinatable()
        case .projects:
            return NavigationViewCoordinator(ProjectsCoordinator()).eraseToAnyCoordinatable()
        case .profile:
            return NavigationViewCoordinator(ProfileCoordinator()).eraseToAnyCoordinatable()
        case .testbedEO:
            return NavigationViewCoordinator(TestbedEnvironmentObjectCoordinator()).eraseToAnyCoordinatable()
        case .testbedRO:
            return NavigationViewCoordinator(TestbedRouterObjectCoordinator()).eraseToAnyCoordinatable()
        }
    }
}
