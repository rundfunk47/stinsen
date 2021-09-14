import Foundation
import SwiftUI

import Stinsen

final class MainCoordinator: NavigationCoordinatable {
    var stack = NavigationStack<MainCoordinator>(initialRoute: \MainCoordinator.start)

    @Route var start = makeStart
    @Route var unauthenticated = makeUnauthenticated
    @Route var authenticated = makeAuthenticated
    
    @ViewBuilder func customize(_ view: AnyView) -> some View {
        if #available(iOS 14.0, *) {
            view.onOpenURL { url in
                print(url)
                // very naive deeplinking
                // please implement a better one in your app
                let urlString = url.absoluteString.dropFirst(13)
                let split = urlString.split(separator: "/")
                guard split[0] == "todo" else { return }
                
                guard let todoId = TodosStore.shared.all.first(where: { todo in
                    todo.name.lowercased() == split[1].lowercased()
                })?.id else { return }
                
                // you should really do some kind of auth-check here
                self
                    .setRoot(\.authenticated, User(username: "username", accessToken: "token"))
                    .focusFirst(\.todos)
                    .child
                    .route(to: \.todo, todoId)
            }
        } else {
            view
        }
    }
}
