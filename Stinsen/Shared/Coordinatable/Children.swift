import Foundation

///Container class for child coordinators. Usually you would initialize this without parameters.
public class Children: ObservableObject {
    @Published var activeChildCoordinator: AnyCoordinatable?
    @Published var activeModalChildCoordinator: AnyCoordinatable?
    
    public init(
        activeChildCoordinator: AnyCoordinatable? = nil,
        activeModalChildCoordinator: AnyCoordinatable? = nil
    ) {
        self.activeChildCoordinator = activeChildCoordinator
        self.activeModalChildCoordinator = activeModalChildCoordinator
    }
}

extension Children {
    var allChildren: [AnyCoordinatable] {
        guard let child = self.activeChildCoordinator else {
            return []
        }
        
        return [child] + child.children.allChildren
    }
    
    func containsChild(child: AnyCoordinatable) -> Bool {
        return allChildren.contains { coordinator -> Bool in
            coordinator.id == child.id
        }
    }
}
