import SwiftUI

import Stinsen

@available(iOS 14.0, *)
struct StinsenApp: App {
    var body: some Scene {
        WindowGroup {
            MainCoordinator()
                .view()
        }
    }
}
