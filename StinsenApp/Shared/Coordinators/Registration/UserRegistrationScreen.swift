import Foundation
import SwiftUI
import Stinsen

struct UserRegistrationScreen: View {
    @EnvironmentObject private var registrationRouter: RegistrationCoordinator.Router
    @State private var text: String = ""

    @ViewBuilder var body: some View {
        ScrollView {
            InfoText("Please enter your desired username")
            RoundedTextField("Desired username", text: $text)
            Spacer(minLength: 32)
            RoundedButton("Next step", style: .primary) {
                registrationRouter.route(to: \.password, text)
            }
        }
        .navigationTitle(with: "Register user")
    }
}

struct UserRegistrationScreen_Previews: PreviewProvider {
    static var previews: some View {
        UserRegistrationScreen()
    }
}

