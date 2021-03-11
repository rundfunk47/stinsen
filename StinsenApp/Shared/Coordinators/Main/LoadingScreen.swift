import Foundation
import SwiftUI

import Stinsen

struct LoadingScreen: View {
    @EnvironmentObject var main: ViewRouter<MainCoordinator.Route>
    
    var body: some View {
        Group {
            if #available(iOS 14.0, *) {
                ProgressView()
            } else {
                Text("Loading...")
            }
        }.onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                main.route(to: .unauthenticated)
            }
        })
    }
}
