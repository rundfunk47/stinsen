import Foundation
import SwiftUI

import Stinsen

struct ForgotPasswordScreen: View {
    @EnvironmentObject var unauthenticated: UnauthenticatedCoordinator.Router
    @State var text: String = ""
    
    var body: some View {
        ScrollView {
            VStack {
                InfoText("Forgot your password? No problem! Just enter your username below and we will send it to you (actually, we won't, this is just to showcase how to navigate back in a flow).")
                Spacer(minLength: 16)
                RoundedTextField("Username", text: $text)
                Spacer(minLength: 32)
                RoundedButton("OK") {
                    unauthenticated.popToRoot()
                }
            }
            .navigationTitle(with: "Forgot password")
        }
    }
}

struct ForgotPasswordScreen_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordScreen()
    }
}
