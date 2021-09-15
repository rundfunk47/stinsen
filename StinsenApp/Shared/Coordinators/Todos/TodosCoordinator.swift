import Foundation
import SwiftUI
import Stinsen

final class TodosCoordinator: NavigationCoordinatable {
    let stack = NavigationStack(initial: \TodosCoordinator.start)

    @Route var start = makeStart
    @Route(.push) var todo = makeTodo
    @Route(.modal) var createTodo = makeCreateTodo
}
