import Foundation
import SwiftUI

import Stinsen

final class MainCoordinator: ViewCoordinatable {
    var child: ViewChild = ViewChild()

    @Route var unauthenticated = makeUnauthenticated
    @Route var authenticated = makeAuthenticated
}
