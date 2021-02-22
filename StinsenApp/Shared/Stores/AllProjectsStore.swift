import Foundation

class AllProjectsStore: ObservableObject {
    static var shared = AllProjectsStore()
    
    @Published private(set) var projects: [Project]
    
    init() {
        projects = [

        ]
    }
    
    func add(project: Project) {
        self.projects.append(project)
    }
}
