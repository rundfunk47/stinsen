import Foundation
import SwiftUI
import Stinsen

struct PasswordRegistrationScreen: View {
    private let services: UnauthenticatedServices
    @EnvironmentObject private var registrationRouter: RegistrationCoordinator.Router

    @State private var password: String = ""
    @State private var passwordAgain: String = ""

    private let username: String
    
    var body: some View {
        ScrollView {
            InfoText("Please enter your desired password")
            RoundedTextField("Enter password", text: $password, secure: true)
            RoundedTextField("Enter password again", text: $passwordAgain, secure: true)
            Spacer(minLength: 32)
            RoundedButton("Register", style: .primary) {
                services.userRegistration.register(username: username, password: password) {
                    registrationRouter.dismissCoordinator()
                }
            }
        }
        .navigationTitle(with: "Register user")
    }
    
    init(services: UnauthenticatedServices, username: String) {
        self.services = services
        self.username = username
    }
}

struct PasswordRegistrationScreen_Previews: PreviewProvider {
    static var previews: some View {
        PasswordRegistrationScreen(services: UnauthenticatedServices(), username: "user@example.com")
    }
}
