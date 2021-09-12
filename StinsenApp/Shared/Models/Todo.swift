import Foundation

struct Todo: Identifiable, Equatable {
    let id: UUID
    var name: String
    var isFavorite: Bool
    
    init(name: String) {
        self.id = UUID()
        self.name = name
        self.isFavorite = false
    }
}
