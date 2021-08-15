import Foundation
import Stinsen

class TestBedRouterObjectViewModel: ObservableObject {
    @RouterObject private var router: NavigationRouter<TestbedRouterObjectCoordinator.Route>?
    @Published var text: String = ""
    
    func modalScreen() {
        router?.route(to: .modalScreen)
    }
    
    func pushScreen() {
        router?.route(to: .pushScreen)
    }
    
    func modalCoordinator() {
        router?.route(to: .modalCoordinator)
    }
    
    func pushCoordinator() {
        router?.route(to: .pushCoordinator)
    }
    
    func dismiss() {
        router?.dismiss(onFinished: {
            print("bye!")
        })
    }
    
    var id: Int? {
        router?.id
    }
}
