import SwiftUI

import Stinsen

@main
struct StinsenApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            CoordinatorView(
                MainCoordinator()
            )
        }
    }
}
