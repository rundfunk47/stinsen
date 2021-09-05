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
            if #available(iOS 14.0, watchOS 7.0, tvOS 14.0, *) {
                return .fullScreen(
                    AnyCoordinatable(
                        CreateProjectCoordinator()
                    )
                )
            }
            return .modal(
                AnyCoordinatable(
                    NavigationViewCoordinator(CreateProjectCoordinator())
                )
            )
        }
    }
    
    @ViewBuilder func start() -> some View {
        ProjectsScreen()
    }
}
