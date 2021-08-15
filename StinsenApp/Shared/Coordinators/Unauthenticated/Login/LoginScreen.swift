import Foundation
import SwiftUI

import Stinsen

struct LoginScreen: View {
    @EnvironmentObject var main: ViewRouter<MainCoordinator.Route>
    @EnvironmentObject var unauthenticated: NavigationRouter<UnauthenticatedCoordinator.Route>

    @StateObject var viewModel = LoginScreenViewModel()
    
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
                    viewModel.loginButtonPressed()
                }
                RoundedButton("Forgot password", style: .secondary) {
                    viewModel.forgotPasswordButtonPressed()
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
