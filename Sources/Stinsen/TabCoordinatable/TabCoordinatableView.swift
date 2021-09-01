import Foundation
import SwiftUI

struct TabCoordinatableView<T: TabCoordinatable, U: View>: View {
    private var coordinator: T
    private let router: TabRouter<T.Route>
    @ObservedObject var child: TabChild<T>
    private var customize: (AnyView) -> U
    private var views: [(T.Route, AnyView)]
    
    var body: some View {
        customize(
            AnyView(
                TabView(selection: $child.activeTab) {
                    ForEach(Array(views.enumerated()), id: \.offset) { view in
                        view
                            .element
                            .1
                            .tabItem {
                                self.coordinator.tabItem(forRoute: view.element.0)
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
        
        self.views = coordinator.children.value.map {
            return ($0.0, $0.1.coordinatorView())
        }
    }
}
