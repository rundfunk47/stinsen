import Foundation
import SwiftUI
import Stinsen

struct CreateTodoScreen: View {
    @State private var text: String = ""
    @EnvironmentObject private var todosRouter: TodosCoordinator.Router
    @ObservedObject private var todosStore: TodosStore
    
    var body: some View {
        VStack {
            RoundedTextField("Todo name", text: $text)
            RoundedButton("Create") {
                todosStore.all.append(Todo(name: text))
                todosRouter.popToRoot()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    init(todosStore: TodosStore) {
        self.todosStore = todosStore
    }
}

struct CreateTodoScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreateTodoScreen(todosStore: TodosStore(user: User(username: "user@example.com", accessToken: UUID().uuidString)))
    }
}
