import Foundation
import SwiftUI
import Stinsen

struct ProfileScreen: View {
    @EnvironmentObject var mainRouter: MainCoordinator.Router

    var body: some View {
        ScrollView {
            VStack {
                RoundedButton("Logout") {
                    mainRouter.route(to: \.unauthenticated)
                }
            }
        }
        .navigationTitle(with: "Profile")
    }
}
