import Foundation
import SwiftUI

import Stinsen

final class MainCoordinator: ViewCoordinatable {
    lazy var children = ViewChild(self)
    
    enum Route {
        case unauthenticated
        case authenticated
    }
    
    func resolveRoute(route: Route) -> AnyCoordinatable {
        switch route {
        case .unauthenticated:
            return AnyCoordinatable(
                NavigationViewCoordinator(
                    UnauthenticatedCoordinator()
                )
            )
        case .authenticated:
            return AnyCoordinatable(
                AuthenticatedCoordinator()
            )
        }
    }
    
    @ViewBuilder func customize(_ view: AnyView) -> some View {
        if #available(iOS 14.0, *) {
            view
                .onOpenURL(perform: { url in
                    if url.absoluteString.starts(with: "stinsenapp://projects") {
                        try! self.handleDeepLink(
                            [
                                MainCoordinator.Route.authenticated,
                                AuthenticatedCoordinator.Route.projects
                            ]
                        )
                    } else if url.absoluteString.starts(with: "stinsenapp://home") {
                        try! self.handleDeepLink(
                            [
                                MainCoordinator.Route.authenticated,
                                AuthenticatedCoordinator.Route.home
                            ]
                        )
                    } else if url.absoluteString.starts(with: "stinsenapp://project") {
                        let substring = url.absoluteString.dropFirst(21)
                        
                        let project = AllProjectsStore.shared.projects.first { project in
                            project.name.lowercased() == substring.lowercased()
                        }
                        
                        if let project = project {
                            try! self.handleDeepLink(
                                [
                                    MainCoordinator.Route.authenticated,
                                    AuthenticatedCoordinator.Route.projects,
                                    ProjectsCoordinator.Route.project(id: project.id)
                                ]
                            )
                        } else {
                            print("Deeplink URL not handled!")
                        }
                    } else if url.absoluteString.starts(with: "stinsenapp://profile") {
                        try! self.handleDeepLink([MainCoordinator.Route.authenticated, AuthenticatedCoordinator.Route.profile])
                    } else {
                        print("Deeplink URL not handled!")
                    }
                })
        } else {
            view
        }
    }
    
    @ViewBuilder func start() -> some View {
        LoadingScreen()
    }
    
    init() {
        
    }
}
