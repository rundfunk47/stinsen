import Foundation
import Stinsen

class LoginScreenViewModel: ObservableObject {
    
    var main: ViewRouter<MainCoordinator.Route>? = RouterStore.shared.retrieve()
    
    @RouterObject
    var unauthenticated: NavigationRouter<UnauthenticatedCoordinator.Route>?
    
    init() {
        
    }
    
    func loginButtonPressed() {
        main?.route(to: .authenticated)
    }
    
    func forgotPasswordButtonPressed() {
        unauthenticated?.route(to: .forgotPassword)
    }
}
