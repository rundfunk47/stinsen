import Foundation
import SwiftUI

struct TabCoordinatableView<T: TabCoordinatable, U: View>: View {
    @ObservedObject var coordinator: T
    private let router: TabRouter<T.Route>
    @ObservedObject var child: TabChild<T>
    private var customize: (AnyView) -> U
    private var views: [AnyView]
    
    var body: some View {
        customize(
            AnyView(
                TabView(selection: $child.activeTab) {
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
        RouterStore.shared.store(router: router)
        self.customize = customize
        self.child = coordinator.children
        
        self.views = coordinator.children.coordinators.map {
            return $0.1.coordinatorView()
        }
    }
}
