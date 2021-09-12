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
    
    @ViewBuilder var body: some View {
        #if os(watchOS)
        ScrollView {
            button
            ForEach(store.all) { todo in
                Button(todo.name, action: {
                    todos.route(to: \.todo, todo.id)
                })
            }
        }
        .navigationTitle(with: "Todos")
        #else
        List(store.all) { todo in
            Button(todo.name, action: {
                todos.route(to: \.todo, todo.id)
            })
        }
        .navigationTitle(with: "Todos")
        .navigationBarItems(
            trailing: button
        )
        #endif
    }
}
