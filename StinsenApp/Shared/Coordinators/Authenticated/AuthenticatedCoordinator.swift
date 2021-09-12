import Foundation
import SwiftUI
import Stinsen

final class AuthenticatedCoordinator: TabCoordinatable {
    var child = TabChild(
        startingItems: [
            \AuthenticatedCoordinator.home,
            \AuthenticatedCoordinator.todos,
            \AuthenticatedCoordinator.profile,
            \AuthenticatedCoordinator.testbed
        ]
    )
    
    private var user: User

    @Route(tabItem: makeHomeTab) var home = makeHome
    @Route(tabItem: makeTodosTab) var todos = makeTodos
    @Route(tabItem: makeProfileTab) var profile = makeProfile
    @Route(tabItem: makeTestbedTab) var testbed = makeTestbed
    
    init(user: User) {
        self.user = user
    }
    
    func customize(_ view: AnyView) -> some View {
        view.accentColor(Color("AccentColor"))
    }    
}
