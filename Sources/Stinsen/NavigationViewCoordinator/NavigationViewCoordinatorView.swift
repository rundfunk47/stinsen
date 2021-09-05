import Foundation
import SwiftUI

struct NavigationViewCoordinatorView<T: NavigationViewCoordinator<V>, U: View, V: View>: View {
    var coordinator: T    
    @EnvironmentObject private var root: RootCoordinator
    private var view: AnyView
    private var customize: (AnyView) -> U

    init(coordinator: T, customize: @escaping (AnyView) -> U) {
        self.coordinator = coordinator
        self.view = coordinator.children.childCoordinator!.coordinatorView()
        self.customize = customize
    }
    
    var body: some View {
        #if os(macOS)
        NavigationView {
            customize(AnyView(view))
        }
        .onReceive(coordinator.children.$childCoordinator) { (value) in
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
        }
        #else
        NavigationView {
            customize(AnyView(view))
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onReceive(coordinator.children.$childCoordinator) { (value) in
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
        }
        #endif
    }
}
