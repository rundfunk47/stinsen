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
    
    @available(iOS 14.0, watchOS 7.0, tvOS 14.0, *)
    func coverScreen() {
        router?.route(to: .coverScreen)
    }
    
    func modalCoordinator() {
        router?.route(to: .modalCoordinator)
    }
    
    func pushCoordinator() {
        router?.route(to: .pushCoordinator)
    }
    
    @available(iOS 14.0, watchOS 7.0, tvOS 14.0, *)
    func coverCoordinator() {
        router?.route(to: .coverCoordinator)
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
