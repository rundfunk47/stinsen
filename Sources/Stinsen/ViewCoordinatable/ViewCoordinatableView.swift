import Foundation
import SwiftUI

struct ViewCoordinatableView<T: ViewCoordinatable, U: View>: View {
    var coordinator: T
    let router: ViewRouter<T>
    @ObservedObject var child: ViewChild
    private var customize: (AnyView) -> U

    init(coordinator: T, customize: @escaping (AnyView) -> U) {
        self.router = ViewRouter(coordinator)
        RouterStore.shared.store(router: router)
        self.customize = customize
        self.coordinator = coordinator
        self.child = coordinator.child
    }
        
    var body: some View {
        customize(
            AnyView(
                Group {
                    if let child = self.child.item?.child {
                        child.view()
                    } else {
                        coordinator.start()
                    }
                }
            )
        )
        .environmentObject(router)
    }
}
