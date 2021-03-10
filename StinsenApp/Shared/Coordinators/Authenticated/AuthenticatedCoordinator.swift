import Foundation
import SwiftUI

import Stinsen

final class AuthenticatedCoordinator: TabCoordinatable {
    lazy var children = TabChild(self, tabRoutes: [.home, .projects, .profile, .testbed])
    
    enum Route: TabRoute {
        case home
        case projects
        case profile
        case testbed
    }
    
    func tabItem(forTab tab: Int) -> some View {
        switch tab {
        case 0:
            Group {
                if children.activeTab == 0 {
                    Image(systemName: "house.fill")
                } else {
                    Image(systemName: "house")
                }
                Text("Home")
            }
        case 1:
            Group {
                if children.activeTab == 1 {
                    Image(systemName: "doc.text.fill")
                } else {
                    Image(systemName: "doc.text")
                }
                Text("Projects")
            }
        case 2:
            Group {
                if children.activeTab == 2 {
                    Image(systemName: "person.fill")
                } else {
                    Image(systemName: "person")
                }
                Text("Profile")
            }
        case 3:
            Group {
                if children.activeTab == 3 {
                    Image(systemName: "bed.double.fill")
                } else {
                    Image(systemName: "bed.double")
                }
                Text("Testbed")
            }
        default:
            fatalError()
        }
    }
    
    func resolveRoute(route: Route) -> AnyCoordinatable {
        switch route {
        case .home:
            return NavigationViewCoordinatable(HomeCoordinator()).eraseToAnyCoordinatable()
        case .projects:
            return NavigationViewCoordinatable(ProjectsCoordinator()).eraseToAnyCoordinatable()
        case .profile:
            return NavigationViewCoordinatable(ProfileCoordinator()).eraseToAnyCoordinatable()
        case .testbed:
            return NavigationViewCoordinatable(TestbedCoordinator()).eraseToAnyCoordinatable()
        }
    }
}
