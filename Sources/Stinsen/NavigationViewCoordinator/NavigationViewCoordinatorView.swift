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
        #else
        NavigationView {
            view
        }
        .navigationViewStyle(StackNavigationViewStyle())
        #endif
    }
}
