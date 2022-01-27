import Foundation
import SwiftUI
import Stinsen

final class TodosCoordinator: NavigationCoordinatable {
    let stack = NavigationStack(initial: \TodosCoordinator.start)

    @Root var start = makeStart
    @Route(.push) var todo = makeTodo
    @Route(.push) var todoDetails = makeTodoDetails
    @Route(.modal) var createTodo = makeCreateTodo
    
    func makeTodoDetails(id: UUID) -> some View {
        Color.red
    }
    
    let todosStore: TodosStore
    
    init(todosStore: TodosStore) {
        self.todosStore = todosStore
    }
    
    deinit {
        print("Deinit TodosCoordinator")
    }
}
