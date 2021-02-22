import Foundation
import SwiftUI

struct RootCoordinatableView<T: RootCoordinatable>: View {
    var coordinator: T
    @ObservedObject var children: Children
    let router: RootRouter<T>
    
    init(coordinator: T) {
        self.router = RootRouter(coordinator)
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
        .environmentObject(ParentCoordinator(coordinator: coordinator))
        .environmentObject(NavigationRootCoordinator(coordinator: coordinator))
    }
}
