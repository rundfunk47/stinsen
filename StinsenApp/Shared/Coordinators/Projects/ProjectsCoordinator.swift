import Foundation
import SwiftUI

import Stinsen

class ProjectsCoordinator: NavigationCoordinatable {
    var children = Children()
    var navigationStack: NavigationStack<Route> = NavigationStack()

    enum Route {
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
                    NavigationViewCoordinatable(childCoordinator: CreateProjectCoordinator())
                )
            )
        }
    }
    
    @ViewBuilder func start() -> some View {
        ProjectsScreen()
    }
}
