import Foundation
import SwiftUI
import Stinsen

struct TodoScreen: View {
    private let todoId: UUID
    
    @EnvironmentObject private var todosRouter: TodosCoordinator.Router
    @ObservedObject private var todos = TodosStore.shared
    
    var content: some View {
        ScrollView {
            InfoText("This is the details screen for your todo.")
            #if os(watchOS)
            button
            #endif
        }
        .navigationTitle(with: todos[todoId].name)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    var button: some View {
        Button(action: {
            todos[todoId].isFavorite.toggle()
        }, label: {
            Image(systemName: "star" + (todos[todoId].isFavorite ? ".fill" : ""))
        })
    }
    
    var body: some View {
        #if os(watchOS)
        content
        #else
        content
            .navigationBarItems(trailing: button)
        #endif
    }
    
    init(todoId: UUID) {
        self.todoId = todoId
    }
}
