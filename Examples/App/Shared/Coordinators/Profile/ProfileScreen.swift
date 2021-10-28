import Foundation
import SwiftUI
import Stinsen

struct ProfileScreen: View {
    private let user: User
    
    @ViewBuilder var body: some View {
        ScrollView {
            VStack {
                switch AuthenticationService.shared.status {
                case .authenticated(let user):
                    InfoText("Currently logged in as \(user.username)")
                case .unauthenticated:
                    EmptyView() // shouldn't happen
                }
                Spacer(minLength: 16)
                RoundedButton("Logout") {
                    AuthenticationService.shared.status = .unauthenticated
                }
            }
        }
        .navigationTitle(with: "Profile")
    }
    
    init(user: User) {
        self.user = user
    }
}

struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen(user: User(username: "user@example.com", accessToken: UUID().uuidString))
    }
}

