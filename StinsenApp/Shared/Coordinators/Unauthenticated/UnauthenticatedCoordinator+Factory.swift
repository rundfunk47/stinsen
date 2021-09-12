import Foundation
import SwiftUI
import Stinsen

extension UnauthenticatedCoordinator {
    @ViewBuilder func makeForgotPassword() -> some View {
        ForgotPasswordScreen()
    }
    
    @ViewBuilder func start() -> some View {
        LoginScreen()
    }
}
