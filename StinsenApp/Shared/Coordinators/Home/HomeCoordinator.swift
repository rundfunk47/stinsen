import Foundation
import SwiftUI

import Stinsen

final class HomeCoordinator: NavigationCoordinatable {    
    let stack = NavigationStack(initial: \HomeCoordinator.start)    

    @Route var start = makeStart
}
