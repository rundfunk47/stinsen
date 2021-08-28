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
                if #available(iOS 14.0, watchOS 7.0, tvOS 14.0, *) {
                    RoundedButton("Cover screen") {
                        viewModel.coverScreen()
                    }
                }
                RoundedButton("Modal coordinator") {
                    viewModel.modalCoordinator()
                }
                RoundedButton("Push coordinator") {
                    viewModel.pushCoordinator()
                }
                if #available(iOS 14.0, watchOS 7.0, tvOS 14.0, *) {
                    RoundedButton("Cover coordinator") {
                        viewModel.coverCoordinator()
                    }
                }
                RoundedButton("Dismiss me!") {
                    viewModel.dismiss()
                }
            }
        }
    }
}
