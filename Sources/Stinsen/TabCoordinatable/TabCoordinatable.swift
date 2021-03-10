import Foundation
import SwiftUI

/// The TabCoordinatable is used to represent a coordinator with a TabView
public protocol TabCoordinatable: Coordinatable {
    var activeTab: Int { get set }
    /// All possible coordinators
    var coordinators: [AnyCoordinatable] { get set }
    associatedtype ViewType: View
    associatedtype CustomizeViewType: View
    @ViewBuilder func tabItem(forTab tab: Int) -> ViewType
    func customize(_ view: AnyView) -> CustomizeViewType
    var children: Children { get }
}

public extension TabCoordinatable {
    var childDismissalAction: DismissalAction {
        get {
            children.childDismissalAction
        } set {
            children.childDismissalAction = newValue
        }
    }
    
    var childCoordinators: [AnyCoordinatable] {
        children.childCoordinators
    }
    
    var appearingMetadata: AppearingMetadata? {
        return nil
    }

    func coordinatorView() -> AnyView {
        AnyView(
            TabCoordinatableView(coordinator: self, customize: customize).onAppear(perform: {
                self.children.childCoordinators = [self.coordinators[0]] // default to zero
            })
        )
    }
    
    func customize(_ view: AnyView) -> some View {
        return view
    }
    
    var activeTab: Int {
        get {
            for tuple in self.coordinators.enumerated() {
                if tuple.element.id == self.childCoordinators.first?.id {
                    return tuple.offset
                }
            }
            
            // no child found, default to 0
            return 0
        } set {
            self.children.childCoordinators = [self.coordinators[newValue]]
        }
    }
    
    func dismissChildCoordinator(_ childCoordinator: AnyCoordinatable, _ completion: (() -> Void)?) {
        fatalError("not implemented")
    }
}
