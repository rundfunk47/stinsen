import Foundation
import SwiftUI

struct InfoText: View {
    let text: String

    var body: some View {
        #if os(macOS)
        standard
        #elseif os(watchOS)
        standard
        #elseif os(tvOS)
        standard
        #elseif os(iOS)
        ios
        #else
        standard
        #endif
    }
    
    var ios: some View {
        Text(text)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(18)
    }
    
    var standard: some View {
        Text(text)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    init(_ text: String) {
        self.text = text
    }
}
