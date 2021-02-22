//
//  ProjectCoordinator.swift
//  Coordinate (iOS)
//
//  Created by Narek Mailian on 2021-01-15.
//

import Foundation
import SwiftUI

class ProjectsCoordinator: NavigationStackCoordinatable {
    var activeChildCoordinator: AnyCoordinatable?
    
    enum Route {
        case project
    }

    var navigationStack: NavigationStack<Route> = NavigationStack()

    func resolveRoute(route: Route) -> RouteType {
        fatalError()
    }
    
    func start() -> AnyView {
        AnyView(ProjectsScreen())
    }
}
