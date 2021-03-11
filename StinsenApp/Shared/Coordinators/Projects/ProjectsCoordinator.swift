import Foundation
import SwiftUI

import Stinsen

class ProjectsCoordinator: NavigationCoordinatable {
    var navigationStack: NavigationStack = NavigationStack()

    enum Route: NavigationRoute {
        case project(id: UUID)
        case createProject
    }
    
    func resolveRoute(route: Route) -> Transition {
        switch route {
        case .project(let id):
            return .push(AnyView(ProjectSummaryScreen(id: id)))
        case .createProject:
            return .modal(
                AnyCoordinatable(
                    NavigationViewCoordinatable(CreateProjectCoordinator())
                )
            )
        }
    }
    
    @ViewBuilder func start() -> some View {
        ProjectsScreen()
    }
}
