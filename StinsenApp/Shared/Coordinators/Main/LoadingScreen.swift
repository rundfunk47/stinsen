import Foundation
import SwiftUI

import Stinsen

struct LoadingScreen: View {
    @EnvironmentObject var main: RootRouter<MainCoordinator>
    
    var body: some View {
        ProgressView()
            .onAppear(perform: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    main.route(to: .unauthenticated)
                }
            })
    }
}
