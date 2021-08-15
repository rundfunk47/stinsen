import Foundation
import SwiftUI

import Stinsen

struct TestbedRouterObjectScreen: View {
    @StateObject var viewModel = TestBedRouterObjectViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Number in coordinator stack: " + String(viewModel.id ?? -1))
                TextField("Textfield", text: $viewModel.text)
                RoundedButton("Modal screen") {
                    viewModel.modalScreen()
                }
                RoundedButton("Push screen") {
                    viewModel.pushScreen()
                }
                RoundedButton("Modal coordinator") {
                    viewModel.modalCoordinator()
                }
                RoundedButton("Push coordinator") {
                    viewModel.pushCoordinator()
                }
                RoundedButton("Dismiss me!") {
                    viewModel.dismiss()
                }
            }
        }
    }
}
