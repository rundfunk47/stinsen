import Foundation
import SwiftUI

import Stinsen

struct CreateProjectScreen: View {
    @EnvironmentObject var createProject: NavigationRouter<CreateProjectCoordinator>
    @State var text: String = ""

    var body: some View {
        ScrollView {
            VStack {
                Spacer(minLength: 16)
                RoundedTextField("Name", text: $text)
                Spacer(minLength: 32)
                RoundedButton("OK") {
                    AllProjectsStore.shared.add(project: Project(name: text))
                    createProject.dismiss()
                }
            }
            .navigationBarTitle("Create project")
        }
    }
}
