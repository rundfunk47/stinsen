import Foundation

class UnauthenticatedServices: ObservableObject {
    var userRegistration: UserRegistrationService = UserRegistrationService()
    var forgotPassword: ForgotPasswordService = ForgotPasswordService()
    var login: LoginService = LoginService()

    init() {
        
    }
}
