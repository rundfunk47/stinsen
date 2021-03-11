import Foundation
import SwiftUI

struct NavigationViewCoordinatableView<T: NavigationViewCoordinatable>: View {
    var coordinator: T    
    @EnvironmentObject private var root: RootCoordinator
    private var view: AnyView

    init(coordinator: T) {
        self.coordinator = coordinator
        view = coordinator.children.childCoordinators.first!.coordinatorView()
    }
        
    var body: some View {
        NavigationView {
            view
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onReceive(coordinator.children.$childCoordinators) { (value) in
            if value.isEmpty {
                guard let parent = root.coordinator.allChildCoordinators.first(where: {
                    $0.childCoordinators.contains(where: {
                        coordinator.id == $0.id
                    })
                }) else {
                    fatalError("no children, cannot dismiss?!")
                }
                
                parent.dismissChildCoordinator( 
                    coordinator.eraseToAnyCoordinatable(),
                    coordinator.children.childDismissalAction
                )
            }
        }
    }
}
