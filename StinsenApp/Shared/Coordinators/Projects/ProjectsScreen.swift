import Foundation
import SwiftUI

import Stinsen

struct ProjectsScreen: View {
    @EnvironmentObject var projects: NavigationRouter<ProjectsCoordinator.Route>
    @ObservedObject var store: AllProjectsStore = .shared
    
    var body: some View {
        ScrollView {
            VStack {
                Spacer(minLength: 16)
                if (store.projects.isEmpty) {
                    InfoText("No projects found on device.")
                } else {
                    ForEach(store.projects) { project in
                        RoundedButton(project.name, style: .secondary, action: {
                            projects.route(to: .project(id: project.id))
                        })
                    }
                }
                Spacer(minLength: 32)
                RoundedButton("Create project", action: {
                    projects.route(to: .createProject)
                })
            }
        }
        .navigationTitle(with: "Projects")
    }
}
