import Foundation
import SwiftUI
import Stinsen

struct HomeScreen: View {
    @EnvironmentObject var authenticatedRouter: AuthenticatedCoordinator.Router
    @ObservedObject var todos = TodosStore.shared
    
    var body: some View {
        ScrollView {
            if todos.favorites.isEmpty {
                InfoText("Welcome to Stinsenapp! If you had any todo's marked as your favorites, they would show up on this page.")
            } else {
                InfoText("Welcome to Stinsenapp! Here are your favorite todos:")
                VStack {
                    #if os(watchOS)
                    button
                    #endif
                    ForEach(todos.favorites) { todo in
                        Button(todo.name) {
                            authenticatedRouter
                                .focusFirst(\.todos)
                                .child
                                .popToRoot()
                                .route(to: \.todo, todo.id)
                        }
                    }
                }
                .padding(18)
            }
        }
        .navigationTitle(with: "Home")
    }
}
