import Foundation
import SwiftUI
import Stinsen

struct TodoScreen: View {
    private let todoId: UUID
    
    @EnvironmentObject private var todosRouter: TodosCoordinator.Router
    @ObservedObject private var todosStore: TodosStore

    var content: some View {
        ScrollView {
            #if !os(iOS)
            button
            #endif
            InfoText("This is the details screen for your todo.")
        }
        .navigationTitle(with: todosStore[todoId].name)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    var button: some View {
        Button(action: {
            todosStore[todoId].isFavorite.toggle()
        }, label: {
            Image(systemName: "star" + (todosStore[todoId].isFavorite ? ".fill" : ""))
        })
    }
    
    var body: some View {
        #if os(iOS)
        content
            .navigationBarItems(trailing: button)
        #else
        content
        #endif
    }
    
    init(todosStore: TodosStore, todoId: UUID) {
        self.todoId = todoId
        self.todosStore = todosStore
    }
}

struct TodoScreen_Previews: PreviewProvider {
    static var previews: some View {
        TodoScreen(todosStore: TodosStore(user: User(username: "user@example.com", accessToken: UUID().uuidString)), todoId: UUID())
    }
}
