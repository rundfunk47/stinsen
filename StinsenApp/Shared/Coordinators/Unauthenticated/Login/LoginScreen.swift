import Foundation
import SwiftUI

import Stinsen

struct LoginScreen: View {
    @EnvironmentObject var mainRouter: MainCoordinator.Router
    @EnvironmentObject var unauthenticatedRouter: UnauthenticatedCoordinator.Router
    
    @State var username: String = ""
    @State var password: String = ""

    var body: some View {
        ScrollView {
            InfoText("Welcome to StinsenApp. This app's purpose is to showcase many of the features Stinsen has to offer. Feel free to look around!")
            VStack {
                Spacer(minLength: 16)
                RoundedTextField("Username", text: $username)
                RoundedTextField("Password", text: $password)
                Spacer(minLength: 32)
                RoundedButton("Login") {
                    mainRouter.root(\.authenticated, User(username: username, accessToken: "token"))
                }
                RoundedButton("Forgot password", style: .secondary) {
                    unauthenticatedRouter.route(to: \.forgotPassword)
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
