import Foundation
import Stinsen

class TestBedRouterObjectViewModel: ObservableObject {
    @RouterObject var testbed: NavigationRouter<TestbedRouterObjectCoordinator.Route>?
    @Published var text: String = ""
}
