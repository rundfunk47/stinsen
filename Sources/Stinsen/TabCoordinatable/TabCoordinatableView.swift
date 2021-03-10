import Foundation
import SwiftUI

struct TabCoordinatableView<T: TabCoordinatable, U: View>: View {
    @ObservedObject var coordinator: T
    private let router: TabRouter<T>
    private let views: [AnyView]
    @ObservedObject var children: Children
    private var customize: (AnyView) -> U
    
    var body: some View {
        customize(
            AnyView(
                TabView(selection: $coordinator.activeTab) {
                    ForEach(Array(views.enumerated()), id: \.offset) { view in
                        view
                            .element
                            .tabItem {
                                self.coordinator.tabItem(forTab: view.offset)
                            }
                            .tag(view.offset)
                    }
                }
            )
        )
        .environmentObject(router)
    }
    
    init(coordinator: T, customize: @escaping (AnyView) -> U) {
        self.coordinator = coordinator
        self.router = TabRouter(coordinator)
        views = coordinator.coordinators.map {
            $0.coordinatorView()
        }
        self.customize = customize
        self.children = coordinator.children
    }
}
