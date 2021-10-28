import Foundation
import SwiftUI
import Stinsen

struct TodosScreen: View {
    @ObservedObject private var todosStore: TodosStore
    @EnvironmentObject private var todosRouter: TodosCoordinator.Router
    
    @ViewBuilder var button: some View {
        Button(action: {
            todosRouter.route(to: \.createTodo)
        }, label: {
            Image(systemName: "folder.badge.plus")
        })
    }
    
    @ViewBuilder var content: some View {
        ScrollView {
            #if !os(iOS)
            button
            #endif
            if todosStore.all.isEmpty {
                InfoText("You have no stored todos.")
            }
            VStack {
                ForEach(todosStore.all) { todo in
                    Button(todo.name, action: {
                        todosRouter.route(to: \.todo, todo.id)
                    })
                }
            }
            .padding(18)
        }
        .navigationTitle(with: "Todos")
    }
    
    @ViewBuilder var body: some View {
        #if os(iOS)
        content
        .navigationBarItems(
            trailing: button
        )
        #else
        content
        #endif
    }
    
    init(todosStore: TodosStore) {
        self.todosStore = todosStore
    }
}

struct TodosScreen_Previews: PreviewProvider {
    static var previews: some View {
        TodosScreen(todosStore: TodosStore(user: User(username: "user@example.com", accessToken: UUID().uuidString)))
    }
}
