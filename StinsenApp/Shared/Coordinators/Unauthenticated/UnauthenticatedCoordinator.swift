import Foundation
import SwiftUI

import Stinsen

final class UnauthenticatedCoordinator: NavigationCoordinatable {
    var stack: NavigationStack = NavigationStack()

    @Route(.push) var forgotPassword = makeForgotPassword
}
