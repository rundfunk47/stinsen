import Foundation

class ForgotPasswordService {    
    func forgot(username: String, callback: (() -> Void)?) {
        DispatchQueue.main.async {
            callback?()
        }
    }
}
