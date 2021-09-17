import Foundation

enum DeepLinkError: LocalizedError {
    case generalError
    
    var errorDescription: String? {
        switch self {
        case .generalError:
            return "Couldn't create deep link"
        }
    }
}

enum DeepLink {
    case todo(id: UUID)
    
    init(url: URL, todosStore: TodosStore) throws {
        // very naive deeplinking
        // please implement a better one in your app
        let urlString = url.absoluteString.dropFirst(13)
        let split = urlString.split(separator: "/")
        guard split[0] == "todo" else { throw DeepLinkError.generalError }
        
        guard let todoId = todosStore.all.first(where: { todo in
            todo.name.lowercased() == split[1].lowercased()
        })?.id else { throw DeepLinkError.generalError }
        
        self = .todo(id: todoId)
    }
}
