import Foundation
import SwiftUI

import Stinsen

final class CreateProjectCoordinator: NavigationCoordinatable {
    lazy var navigationStack = NavigationStack(self)
    
    enum Route: Equatable {

    }

    func resolveRoute(route: Route) -> Transition {

    }
    
    @ViewBuilder func start() -> some View {
        CreateProjectScreen()
    }
}
