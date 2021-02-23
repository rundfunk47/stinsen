import Foundation
import SwiftUI

/// Use this as the top level view in your app.
public struct CoordinatorView: View {
    let coordinator: AnyCoordinatable
    
    public var body: some View {
        coordinator
            .coordinatorView()
            .environmentObject(ParentCoordinator(anyCoordinatable: nil))
            .environmentObject(RootCoordinator(coordinator: coordinator))
    }
    
    public init<T: Coordinatable>(_ coordinator: T) {
        self.coordinator = coordinator.eraseToAnyCoordinatable()
    }
}
