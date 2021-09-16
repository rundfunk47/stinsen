import Foundation
import SwiftUI

struct ViewWrapperCoordinatorView<U: Coordinatable, T: ViewWrapperCoordinator<U, V>, V: View>: View {
    var coordinator: T
    private let childView: AnyView
    private let view: (AnyView) -> V

    init(coordinator: T, @ViewBuilder _ view: @escaping (AnyView) -> V) {
        self.coordinator = coordinator
        self.view = view
        self.childView = coordinator.child.view()
    }
    
    var body: some View {
        view(childView)
    }
}
