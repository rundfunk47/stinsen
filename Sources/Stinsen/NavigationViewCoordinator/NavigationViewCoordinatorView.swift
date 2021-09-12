import Foundation
import SwiftUI

struct NavigationViewCoordinatorView<U: Coordinatable, T: NavigationViewCoordinator<U>>: View {
    var coordinator: T    
    private var view: AnyView

    init(coordinator: T) {
        self.coordinator = coordinator
        self.view = coordinator.child.view()
    }
    
    var body: some View {
        #if os(macOS)
        NavigationView {
            view
        }
        #warning("fix dismissal")
        /*.onReceive(coordinator.children.$childCoordinator) { (value) in
            if value == nil {
                guard let parent = ([root.coordinator] + root.coordinator.allChildCoordinators).first(where: {
                    $0.childCoordinators.contains(where: {
                        coordinator.id == $0.id
                    })
                }) else {
                    fatalError("no children, cannot dismiss?!")
                }
                
                parent.dismissChildCoordinator(
                    coordinator.eraseToAnyCoordinatable(),
                    coordinator.children.dismissalAction
                )
            }
        }*/
        #else
        NavigationView {
            view
        }
        .navigationViewStyle(StackNavigationViewStyle())
        #warning("fix dismissal")
        /*.onReceive(coordinator.children.$childCoordinator) { (value) in
            if value == nil {
                guard let parent = ([root.coordinator] + root.coordinator.allChildCoordinators).first(where: {
                    $0.childCoordinators.contains(where: {
                        coordinator.id == $0.id
                    })
                }) else {
                    fatalError("no children, cannot dismiss?!")
                }
                
                parent.dismissChildCoordinator(
                    coordinator.eraseToAnyCoordinatable(),
                    coordinator.children.dismissalAction
                )
            }
        }*/
        #endif
    }
}
