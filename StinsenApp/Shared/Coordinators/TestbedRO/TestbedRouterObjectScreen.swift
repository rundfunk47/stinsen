import Foundation
import SwiftUI

import Stinsen

struct TestbedRouterObjectScreen: View {
    @StateObject var viewModel = TestBedRouterObjectViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Number in coordinator stack: " + String(viewModel.testbed!.id ?? -1))
                TextField("Textfield", text: $viewModel.text)
                RoundedButton("Modal screen") {
                    viewModel.testbed!.route(to: .modalScreen)
                }
                RoundedButton("Push screen") {
                    viewModel.testbed!.route(to: .pushScreen)
                }
                RoundedButton("Modal coordinator") {
                    viewModel.testbed!.route(to: .modalCoordinator)
                }
                RoundedButton("Push coordinator") {
                    viewModel.testbed!.route(to: .pushCoordinator)
                }
                RoundedButton("Dismiss me!") {
                    viewModel.testbed!.dismiss {
                        print("bye!")
                    }
                }
            }
        }
    }
}
