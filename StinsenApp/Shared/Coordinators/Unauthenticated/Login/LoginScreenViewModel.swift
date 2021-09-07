import Foundation
import Stinsen

class LoginScreenViewModel: ObservableObject {
    
    var main: ViewRouter<MainCoordinator.Route>? = RouterStore.shared.retrieve()
    
    @RouterObject
    var unauthenticated: NavigationRouter<UnauthenticatedCoordinator.Route>?
    
    init() {
        
    }
    
    func loginButtonPressed() {
        main?.activeRoute = .authenticated
    }
    
    func forgotPasswordButtonPressed() {
        unauthenticated?.route(to: .forgotPassword)
    }
}
