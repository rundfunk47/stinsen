import Foundation
import SwiftUI

import Stinsen

struct ProfileScreen: View {
    @EnvironmentObject var main: ViewRouter<MainCoordinator.Route>
    @EnvironmentObject var profile: NavigationRouter<ProfileCoordinator.Route>

    var body: some View {
        ScrollView {
            VStack {
                RoundedButton("Logout") {
                    main.activeRoute = .unauthenticated
                }
            }.navigationTitle(with: "Profile")
        }
    }
}
