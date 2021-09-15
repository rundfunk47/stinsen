import Foundation
import SwiftUI

import Stinsen

final class HomeCoordinator: NavigationCoordinatable {    
    let stack = NavigationStack(initialRoute: \HomeCoordinator.start)    

    @Route var start = makeStart
}
