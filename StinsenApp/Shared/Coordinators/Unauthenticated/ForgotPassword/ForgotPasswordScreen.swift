import Foundation
import SwiftUI

import Stinsen

struct ForgotPasswordScreen: View {
    @EnvironmentObject var unauthenticated: NavigationRouter<UnauthenticatedCoordinator>
    
    @State var text: String = ""
    
    var body: some View {
        ScrollView {
            VStack {
                Spacer(minLength: 16)
                RoundedTextField("Username", text: $text)
                Spacer(minLength: 32)
                RoundedButton("OK") {

                }
            }
            .navigationBarTitle("Forgot Password")
        }
    }
}

struct ForgotPasswordScreen_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordScreen()
    }
}
