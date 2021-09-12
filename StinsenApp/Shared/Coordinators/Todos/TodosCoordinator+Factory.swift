import Foundation
import SwiftUI
import Stinsen

extension TodosCoordinator {
    @ViewBuilder func makeTodo(todoId: UUID) -> some View {
        TodoScreen(todoId: todoId)
    }
    
    @ViewBuilder func makeCreateTodo() -> some View {
        CreateTodoScreen()
    }
    
    @ViewBuilder func start() -> some View {
        TodosScreen()
    }
}
