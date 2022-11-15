import Foundation
import SwiftUI

internal class NavigationViewBuilder {
    
    @ViewBuilder internal static func versionBasedWrapper(view: AnyView) -> some View {
        if #available(iOS 16.0, *) {
            SwiftUI.NavigationStack {
                view
            }
        } else {
            NavigationView {
                view
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
    
}
