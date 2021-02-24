import Foundation
import SwiftUI

import Stinsen

struct ProfileScreen: View {
    @EnvironmentObject var main: ViewRouter<MainCoordinator>
    @EnvironmentObject var profile: NavigationRouter<ProfileCoordinator>

    var body: some View {
        ScrollView {
            VStack {
                RoundedButton("Logout") {
                    main.route(to: .unauthenticated)
                }
            }.navigationBarTitle("Profile")
        }
    }
}
