import Foundation
import SwiftUI

import Stinsen

struct LoadingScreen: View {
    @EnvironmentObject var mainRouter: MainCoordinator.Router
    
    var body: some View {
        Group {
            if #available(iOS 14.0, *) {
                ProgressView()
            } else {
                Text("Loading...")
            }
        }.onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if mainRouter.isStart() {
                    mainRouter.route(to: \.unauthenticated)
                }
            }
        })
    }
}
