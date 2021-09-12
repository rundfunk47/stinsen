import Foundation
import SwiftUI
import Stinsen

final class TodosCoordinator: NavigationCoordinatable {
    var stack = NavigationStack()
    
    @Route(.push) var todo = makeTodo
    @Route(.modal) var createTodo = makeCreateTodo
}
