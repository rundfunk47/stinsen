import Foundation

class FavoriteProjectsStore: ObservableObject {
    static var shared = FavoriteProjectsStore()
    
    @Published private(set) var ids: Set<UUID>
    
    init() {
        ids = [

        ]
    }
    
    func toggle(id: UUID) {
        if ids.contains(id) {
            ids.remove(id)
        } else {
            ids.insert(id)
        }
    }
}
