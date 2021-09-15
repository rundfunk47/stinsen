import Foundation
import SwiftUI

import Stinsen

final class UnauthenticatedCoordinator: NavigationCoordinatable {
    let stack = NavigationStack(initialRoute: \UnauthenticatedCoordinator.start)
    
    @Route var start = makeStart
    @Route(.push) var forgotPassword = makeForgotPassword
}
