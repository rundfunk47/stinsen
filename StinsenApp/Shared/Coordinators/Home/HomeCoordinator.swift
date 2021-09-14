import Foundation
import SwiftUI

import Stinsen

final class HomeCoordinator: NavigationCoordinatable {    
    let stack = NavigationStack(initialRoute: \HomeCoordinator.start)
    func customize(_ view: AnyView) -> some View {
        return view
    }
    

    @Route var start = makeStart
}
