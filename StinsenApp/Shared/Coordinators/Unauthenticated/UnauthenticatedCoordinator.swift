import Foundation
import SwiftUI

import Stinsen

final class UnauthenticatedCoordinator: NavigationCoordinatable {
    let stack = NavigationStack(initial: \UnauthenticatedCoordinator.start)
    
    @Route var start = makeStart
    @Route(.push) var forgotPassword = makeForgotPassword
}
