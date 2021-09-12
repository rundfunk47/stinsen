import Foundation
import SwiftUI
import Stinsen

struct CreateTodoScreen: View {
    @State private var text: String = ""
    @EnvironmentObject private var todos: TodosCoordinator.Router
    
    var body: some View {
        VStack {
            RoundedTextField("Todo name", text: $text)
            RoundedButton("Create") {
                TodosStore.shared.all.append(Todo(name: text))
                todos.popToRoot()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
