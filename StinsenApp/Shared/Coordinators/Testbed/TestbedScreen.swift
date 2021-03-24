import Foundation
import SwiftUI

import Stinsen

struct TestbedScreen: View {
    @EnvironmentObject var testbed: NavigationRouter<TestbedCoordinator.Route>
    @State var text: String = ""
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Number in coordinator stack: " + String(testbed.id ?? -1))
                TextField("Textfield", text: $text)
                RoundedButton("Modal screen") {
                    testbed.route(to: .modalScreen)
                }
                RoundedButton("Push screen") {
                    testbed.route(to: .pushScreen)
                }
                RoundedButton("Modal coordinator") {
                    testbed.route(to: .modalCoordinator)
                }
                RoundedButton("Push coordinator") {
                    testbed.route(to: .pushCoordinator)
                }
                RoundedButton("Dismiss me!") {
                    testbed.dismiss {
                        print("bye!")
                    }
                }
            }
        }
    }
}
