import Foundation
import SwiftUI
import Stinsen

extension ProfileCoordinator {
    @ViewBuilder func makeStart() -> some View {
        ProfileScreen(user: user)
    }
}
