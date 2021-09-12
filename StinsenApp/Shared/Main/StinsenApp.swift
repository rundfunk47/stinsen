import SwiftUI

import Stinsen

@available(iOS 14.0, *)
struct StinsenApp: App {
    var body: some Scene {
        WindowGroup {
            MainCoordinator()
                .view()
                .onAppear {
                    #if os(iOS)
                    let tintColor = UIColor(named: "AccentColor")
                    
                    UITabBar.appearance().tintColor = tintColor
                    #endif
                }
        }
    }
}
