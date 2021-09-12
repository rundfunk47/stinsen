import Foundation

class TodosStore: ObservableObject {
    static var shared = TodosStore()
    
    @Published var all: [Todo]
    
    var favorites: [Todo] {
        all.filter(\.isFavorite)
    }
    
    subscript(todoId: UUID) -> Todo {
        get {
            all.first { todo in
                todo.id == todoId
            }!
        } set {
            let index = all.firstIndex { todo in
                todo.id == todoId
            }!
            
            all[index] = newValue
        }
    }
    
    init() {
        all = []
    }
}
