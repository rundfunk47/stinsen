import Foundation
import SwiftUI

struct TabCoordinatableView<T: TabCoordinatable>: View {
    @ObservedObject var children: Children
    @ObservedObject var coordinator: T
    private let router: TabRouter<T>

    var body: some View {
        TabView(selection: $coordinator.activeTab) {
            ForEach(Array(coordinator.coordinators.enumerated()), id: \.element.id) { coordinator in
                coordinator
                    .element
                    .coordinatorView()
                    .tabItem {
                        self.coordinator.tabItem(forTab: coordinator.offset)
                    }
                    .tag(coordinator.offset)
            }
        }
        .environmentObject(ParentCoordinator(coordinator: coordinator))
        .environmentObject(router)
    }
    
    init(coordinator: T) {
        self.coordinator = coordinator
        self.children = coordinator.children
        self.router = TabRouter(coordinator)
    }
}
