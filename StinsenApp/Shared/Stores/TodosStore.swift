import Foundation

class TodosStore: ObservableObject {
    static var shared = TodosStore()
    
    @Published var all: [Todo] {
        didSet {
            let encoder = JSONEncoder()
            let jsonString = try! encoder.encode(all)
            UserDefaults.standard.setValue(jsonString, forKey: "stored")
        }
    }
    
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
        if let data = UserDefaults.standard.data(forKey: "stored") {
            let decoder = JSONDecoder()
            let decoded = try! decoder.decode([Todo].self, from: data)
            all = decoded
        } else {
            all = []
        }
    }
}
