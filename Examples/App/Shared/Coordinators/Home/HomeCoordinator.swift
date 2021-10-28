import Foundation
import SwiftUI

import Stinsen

final class HomeCoordinator: NavigationCoordinatable {    
    let stack = NavigationStack(initial: \HomeCoordinator.start)    

    @Root var start = makeStart
    
    let todosStore: TodosStore
    
    init(todosStore: TodosStore) {
        self.todosStore = todosStore
    }
    
    deinit {
        print("Deinit HomeCoordinator")
    }
}
