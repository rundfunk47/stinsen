import Foundation
import SwiftUI
import Stinsen

extension HomeCoordinator {
    @ViewBuilder func makeStart() -> some View {
        HomeScreen(todosStore: todosStore)
    }
}
