import Foundation
import SwiftUI

import Stinsen

struct ProfileScreen: View {
    @EnvironmentObject var main: RootRouter<MainCoordinator>

    var body: some View {
        ScrollView {
            VStack {
                RoundedButton("Logout") {
                    main.route(to: .unauthenticated)
                }
            }.navigationTitle("Profile")
        }
    }
}
