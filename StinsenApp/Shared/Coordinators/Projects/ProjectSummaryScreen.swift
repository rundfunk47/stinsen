import Foundation
import SwiftUI

import Stinsen

struct ProjectSummaryScreen: View {
    @EnvironmentObject var projectsCoordinator: NavigationRouter<ProjectsCoordinator.Route>
    @ObservedObject var allProjects: AllProjectsStore = .shared
    @ObservedObject var favoriteProjects: FavoriteProjectsStore = .shared

    let id: UUID
    
    var body: some View {
        ScrollView {
            VStack {
                Spacer(minLength: 16)
                InfoText("Information about the project...")
                Spacer(minLength: 32)
                if !favoriteProjects.ids.contains(id) {
                    RoundedButton("Add to favorites") {
                        favoriteProjects.toggle(id: id)
                    }
                } else {
                    RoundedButton("Remove from favorites") {
                        favoriteProjects.toggle(id: id)
                    }
                }
            }
            .navigationTitle(with: allProjects.projects.first(where: { $0.id == id })!.name)
        }
    }
    
    init(id: UUID) {
        self.id = id
    }
}
