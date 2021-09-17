import Foundation

class AuthenticationService: ObservableObject {
    enum Status: Equatable {
        case authenticated(User)
        case unauthenticated
    }
    
    static var shared: AuthenticationService = AuthenticationService()
    
    @Published var status: Status
    
    init() {
        status = .unauthenticated
    }
}
