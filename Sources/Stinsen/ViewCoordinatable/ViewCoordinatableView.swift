import Foundation
import SwiftUI

struct ViewCoordinatableView<T: ViewCoordinatable>: View {
    var coordinator: T
    let router: ViewRouter<T>
    @ObservedObject var children: Children
    
    init(coordinator: T) {
        self.router = ViewRouter(coordinator)
        self.coordinator = coordinator
        self.children = coordinator.children
    }
        
    var body: some View {
        Group {
            if let childCoordinator = coordinator.childCoordinators.first {
                childCoordinator
                    .coordinatorView()
            } else {
                coordinator
                    .start()
            }
        }
        .environmentObject(router)
    }
}
