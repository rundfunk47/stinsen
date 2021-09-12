import Foundation
import SwiftUI

struct TabCoordinatableView<T: TabCoordinatable, U: View>: View {
    private var coordinator: T
    private let router: TabRouter<T>
    @ObservedObject var child: TabChild
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
                                coordinator.child.allItems[view.offset].tabItem(view.offset == child.activeTab)
                            }
                            .tag(view.offset)
                    }
                }
            )
        )
        .environmentObject(router)
    }
    
    init(paths: [AnyKeyPath], coordinator: T, customize: @escaping (AnyView) -> U) {
        self.coordinator = coordinator
        
        self.router = TabRouter(coordinator)
        RouterStore.shared.store(router: router)
        self.customize = customize
        self.child = coordinator.child
        coordinator.child.allItems = []
                        
        var all: [TabChildItem] = []
        
        for abs in coordinator.child.startingItems {
            let ina = coordinator[keyPath: abs]
            
            if let val = ina as? Outputable {
                all.append(
                    TabChildItem(
                        presentable: val.using(coordinator: coordinator),
                        keyPathIsEqual: {
                            let lhs = abs as! PartialKeyPath<T>
                            let rhs = $0 as! PartialKeyPath<T>
                            return (lhs == rhs)
                        },
                        tabItem: {
                            val.tabItem(active: $0, coordinator: coordinator)
                        }
                    )
                )
            }
        }
        
        self.coordinator.child.allItems = all

        self.views = coordinator.child.allItems.map {
            $0.presentable.view()
        }
    }
}
