import Foundation
import SwiftUI

import Stinsen

struct HomeScreen: View {
    @ObservedObject var favoriteProjects: FavoriteProjectsStore = .shared
    @ObservedObject var allProjects: AllProjectsStore = .shared
    @EnvironmentObject var tabRoute: TabRouter<AuthenticatedCoordinator.Route>
    
    var body: some View {
        ScrollView {
            VStack {
                Spacer(minLength: 16)
                if favoriteProjects.ids.isEmpty {
                    InfoText("Welcome to StinsenApp! If you had any favorite projects, they would be shown here.")
                } else {
                    InfoText("Welcome to StinsenApp! Your favorite projects are listed below for easy access.")
                }
                Spacer(minLength: 32)
                ForEach(Array(favoriteProjects.ids), id: \.self) { id in
                    RoundedButton(allProjects.projects.first(where: { $0.id == id })!.name) {
                        tabRoute.route(to: .projects)
                    }
                }
            }
        }
        .navigationTitle(with: "Home")
    }
    
    init() {
        
    }
}
