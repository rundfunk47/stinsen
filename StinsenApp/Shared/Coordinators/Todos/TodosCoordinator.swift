import Foundation
import SwiftUI
import Stinsen

final class TodosCoordinator: NavigationCoordinatable {
    let stack = NavigationStack(initialRoute: \TodosCoordinator.start)
    func customize(_ view: AnyView) -> some View {
        return view
    }
    

    @Route var start = makeStart
    @Route(.push) var todo = makeTodo
    @Route(.modal) var createTodo = makeCreateTodo
}
