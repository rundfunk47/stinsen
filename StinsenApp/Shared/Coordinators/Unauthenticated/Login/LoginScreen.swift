import Foundation
import SwiftUI

import Stinsen

struct LoginScreen: View {
    @EnvironmentObject var main: ViewRouter<MainCoordinator.Route>
    @EnvironmentObject var unauthenticated: NavigationRouter<UnauthenticatedCoordinator.Route>

    @State var username: String = ""
    @State var password: String = ""

    var body: some View {
        ScrollView {
            VStack {
                Spacer(minLength: 16)
                RoundedTextField("Username", text: $username)
                RoundedTextField("Password", text: $password)
                Spacer(minLength: 32)
                RoundedButton("Login") {
                    main.route(to: .authenticated)
                }
                RoundedButton("Forgot password", style: .secondary) {
                    unauthenticated.route(to: .forgotPassword)
                }
            }
        }
        .navigationTitle(with: "Welcome")
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
