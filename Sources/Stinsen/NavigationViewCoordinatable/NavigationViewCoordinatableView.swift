import Foundation
import SwiftUI

struct NavigationViewCoordinatableView<T: NavigationViewCoordinatable>: View {
    var coordinator: T
    @ObservedObject var children: Children
    @EnvironmentObject var parent: ParentCoordinator

    init(coordinator: T) {
        self.coordinator = coordinator
        self.children = coordinator.children
    }
        
    var body: some View {
        NavigationView {
            if let childCoordinator = children.activeChildCoordinator {
                childCoordinator
                    .coordinatorView()
            } else {
                EmptyView()
            }
        }
        .onReceive(children.objectWillChange, perform: { _ in
            // dismiss this coordinator as well if it has no children
            if self.children.activeChildCoordinator == nil {
                if self.parent.coordinator!.children.activeModalChildCoordinator?.id == coordinator.id {
                    self.parent.coordinator!.children.activeModalChildCoordinator = nil
                }
            }
        })
        .environmentObject(ParentCoordinator(coordinator: coordinator))
    }
}
