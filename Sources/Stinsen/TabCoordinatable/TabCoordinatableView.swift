import Foundation
import SwiftUI

struct TabCoordinatableView<T: TabCoordinatable>: View {
    @ObservedObject var children: Children
    @ObservedObject var coordinator: T
    private let router: TabRouter<T>
    private let views: [AnyView]
    
    var body: some View {
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
        .environmentObject(router)
    }
    
    init(coordinator: T) {
        self.coordinator = coordinator
        self.children = coordinator.children
        self.router = TabRouter(coordinator)
        views = coordinator.coordinators.map {
            $0.coordinatorView()
        }
    }
}
