import Foundation
import SwiftUI

struct NavigationViewCoordinatableView<T: NavigationViewCoordinatable>: View {
    var coordinator: T
    @ObservedObject var children: Children
    @EnvironmentObject private var root: RootCoordinator
    private var view: AnyView

    init(coordinator: T) {
        self.coordinator = coordinator
        self.children = coordinator.children

        view = coordinator.children.activeChildCoordinator!.coordinatorView()
    }
        
    var body: some View {
        NavigationView {
            view
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onReceive(children.objectWillChange, perform: { _ in
            // dismiss this coordinator as well if it has no children
            if self.children.activeChildCoordinator == nil {
                if let parent = root.coordinator.children.allChildren.first { (it) -> Bool in
                    it.children.activeChildCoordinator?.id == coordinator.id
                } {
                    parent.children.activeChildCoordinator = nil
                    let oldClosure = parent.children.onChildDismiss
                    
                    parent.children.onChildDismiss = {
                        oldClosure()
                        self.children.onChildDismiss()
                        self.children.onModalChildDismiss()
                    }
                }
                
                if let modalParent = root.coordinator.children.allChildren.first { (it) -> Bool in
                    it.children.activeModalChildCoordinator?.id == coordinator.id
                } {
                    modalParent.children.activeModalChildCoordinator = nil
                    let oldClosure = modalParent.children.onModalChildDismiss
                    
                    modalParent.children.onModalChildDismiss = {
                        oldClosure()
                        self.children.onChildDismiss()
                        self.children.onModalChildDismiss()
                    }
                }
            }
        })
    }
}
