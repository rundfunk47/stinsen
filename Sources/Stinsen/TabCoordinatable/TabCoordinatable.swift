import Foundation
import SwiftUI

/// The TabCoordinatable is used to represent a coordinator with a TabView
public protocol TabCoordinatable: Coordinatable {
    var activeTab: Int { get set }
    var coordinators: [AnyCoordinatable] { get set }
    associatedtype ViewType: View
    @ViewBuilder func tabItem(forTab tab: Int) -> ViewType
}

public extension TabCoordinatable {
    var appearingMetadata: AppearingMetadata? {
        return nil
    }

    func coordinatorView() -> AnyView {
        AnyView(
            TabCoordinatableView(coordinator: self)
        )
    }
    
    var activeTab: Int {
        get {
            for tuple in self.coordinators.enumerated() {
                if tuple.element.id == self.children.activeChildCoordinator?.id {
                    return tuple.offset
                }
            }
            
            // no child found, default to 0
            return 0
        } set {
            self.children.activeChildCoordinator = self.coordinators[newValue]
        }
    }
}
