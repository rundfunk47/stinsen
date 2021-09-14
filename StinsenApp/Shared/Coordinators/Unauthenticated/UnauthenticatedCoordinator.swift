import Foundation
import SwiftUI

import Stinsen

final class UnauthenticatedCoordinator: NavigationCoordinatable {
    let stack = NavigationStack(initialRoute: \UnauthenticatedCoordinator.start)
    
    func customize(_ view: AnyView) -> some View {
        return view
    }
    
    @Route var start = makeStart
    @Route(.push) var forgotPassword = makeForgotPassword
}
