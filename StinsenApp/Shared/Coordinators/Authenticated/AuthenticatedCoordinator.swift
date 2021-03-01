import Foundation
import SwiftUI

import Stinsen

class AuthenticatedCoordinator: TabCoordinatable {    
    var children = Children()
    
    func tabItem(forTab tab: Int) -> some View {
        switch tab {
        case 0:
            Group {
                if activeTab == 0 {
                    Image(systemName: "house.fill")
                } else {
                    Image(systemName: "house")
                }
                Text("Home")
            }
        case 1:
            Group {
                if activeTab == 1 {
                    Image(systemName: "doc.text.fill")
                } else {
                    Image(systemName: "doc.text")
                }
                Text("Projects")
            }
        case 2:
            Group {
                if activeTab == 2 {
                    Image(systemName: "person.fill")
                } else {
                    Image(systemName: "person")
                }
                Text("Profile")
            }
        case 3:
            Group {
                if activeTab == 3 {
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
    
    var coordinators: [AnyCoordinatable] = [
        NavigationViewCoordinatable(childCoordinator: HomeCoordinator()).eraseToAnyCoordinatable(),
        NavigationViewCoordinatable(childCoordinator: ProjectsCoordinator()).eraseToAnyCoordinatable(),
        NavigationViewCoordinatable(childCoordinator: ProfileCoordinator()).eraseToAnyCoordinatable(),
        NavigationViewCoordinatable(childCoordinator: TestbedCoordinator()).eraseToAnyCoordinatable()
    ]
}
