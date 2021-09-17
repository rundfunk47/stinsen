import Foundation
import SwiftUI
import Stinsen

extension RegistrationCoordinator {
    @ViewBuilder func makeStart() -> some View {
        UserRegistrationScreen()
    }
    
    @ViewBuilder func makePassword(username: String) -> some View {
        PasswordRegistrationScreen(services: services, username: username)
    }
}
