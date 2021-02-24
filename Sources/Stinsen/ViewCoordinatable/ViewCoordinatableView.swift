import Foundation
import SwiftUI

struct ViewCoordinatableView<T: ViewCoordinatable>: View {
    var coordinator: T
    @ObservedObject var children: Children
    let router: ViewRouter<T>
    
    init(coordinator: T) {
        self.router = ViewRouter(coordinator)
        self.coordinator = coordinator
        self.children = coordinator.children
    }
        
    var body: some View {
        Group {
            if let childCoordinator = children.activeChildCoordinator {
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
