import Foundation
import SwiftUI

import Stinsen

final class MainCoordinator: ViewCoordinatable {
    var child: ViewChild = ViewChild()

    @Route var unauthenticated = makeUnauthenticated
    @Route var authenticated = makeAuthenticated
    
    @ViewBuilder func customize(_ view: AnyView) -> some View {
        if #available(iOS 14.0, *) {
            view.onOpenURL { url in
                // very naive deeplinking
                // please implement a better one in your app
                let urlString = url.absoluteString.dropFirst(13)
                let split = urlString.split(separator: "/")
                guard split[0] == "projects" else { return }
                
                guard let todoId = TodosStore.shared.all.first(where: { todo in
                    todo.name.lowercased() == split[1].lowercased()
                })?.id else { return }
                
                // you should really do some kind of auth-check here
                self
                    .route(to: \.authenticated, User(username: "", accessToken: "token"))
                    .focusFirst(\.todos)
                    .child
                    .route(to: \.todo, todoId)
            }
        } else {
            view
        }
    }
}
