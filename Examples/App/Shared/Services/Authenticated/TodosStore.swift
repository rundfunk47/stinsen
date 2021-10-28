import Foundation

class TodosStore: ObservableObject {
    @Published var all: [Todo] {
        didSet {
            let encoder = JSONEncoder()
            let jsonString = try! encoder.encode(all)
            UserDefaults.standard.setValue(jsonString, forKey: "stored+\(user.username)")
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
    
    private let user: User
    
    init(user: User) {
        self.user = user
        
        if let data = UserDefaults.standard.data(forKey: "stored+\(user.username)") {
            let decoder = JSONDecoder()
            let decoded = try! decoder.decode([Todo].self, from: data)
            all = decoded
        } else {
            all = []
        }
    }
}
