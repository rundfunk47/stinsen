import Foundation
import SwiftUI

import Stinsen

struct ProfileScreen: View {
    @EnvironmentObject var main: RootRouter<MainCoordinator>
    @EnvironmentObject var profile: NavigationRouter<ProfileCoordinator>

    var body: some View {
        ScrollView {
            VStack {
                /*Text(String(profile.id ?? -1))
                RoundedButton("Modal") {
                    profile.route(to: .modal)
                }
                RoundedButton("Push") {
                    profile.route(to: .push)
                }*/
                RoundedButton("Logout") {
                    main.route(to: .unauthenticated)
                }
            }.navigationBarTitle("Profile")
        }
    }
}
