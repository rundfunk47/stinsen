import Foundation
import SwiftUI
import Stinsen

struct TodosScreen: View {
    @ObservedObject private var store: TodosStore = .shared
    
    @EnvironmentObject private var main: MainCoordinator.Router
    @EnvironmentObject private var todos: TodosCoordinator.Router
    
    @ViewBuilder var button: some View {
        Button(action: {
            todos.route(to: \.createTodo)
        }, label: {
            Image(systemName: "folder.badge.plus")
        })
    }
    
    @ViewBuilder var content: some View {
        ScrollView {
            if store.all.isEmpty {
                InfoText("You have no stored todos.")
            }
            VStack {
                #if os(watchOS)
                button
                #endif
                ForEach(store.all) { todo in
                    Button(todo.name, action: {
                        todos.route(to: \.todo, todo.id)
                    })
                }
            }
            .padding(18)
        }
        .navigationTitle(with: "Todos")
    }
    
    @ViewBuilder var body: some View {
        #if os(watchOS)
        content
        #else
        content
        .navigationBarItems(
            trailing: button
        )
        #endif
    }
}
