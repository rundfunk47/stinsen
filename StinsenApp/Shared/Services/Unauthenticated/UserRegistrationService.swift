import Foundation

class UserRegistrationService {
    func register(username: String, password: String, callback: (() -> Void)?) {
        DispatchQueue.main.async {
            callback?()
        }
    }
}
