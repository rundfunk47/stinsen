import Foundation

struct Project: Identifiable {
    var name: String
    var id: UUID
    
    init(name: String) {
        self.name = name
        self.id = UUID()
    }
}
