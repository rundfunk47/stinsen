import Foundation
import SwiftUI
import Stinsen

final class ProfileCoordinator: NavigationCoordinatable {
    let stack = NavigationStack(initialRoute: \ProfileCoordinator.start)
    
    func customize(_ view: AnyView) -> some View {
        return view
    }
    
    @Route var start = makeStart
}
