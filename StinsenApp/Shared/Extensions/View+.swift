import SwiftUI

extension View {
    @ViewBuilder
    func navigationTitle(with title: String) -> some View {
        #if os(macOS)
        self.navigationTitle(title)
        #else
        self.navigationBarTitle(title)
        #endif
    }
}
