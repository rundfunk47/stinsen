import Foundation
import SwiftUI

struct RoundedTextField: View {
    let placeholder: String
    let secure: Bool
    var text: Binding<String>
    
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
    
    @ViewBuilder var standard: some View {
        if secure {
            SecureField(placeholder, text: text)
        } else {
            TextField(placeholder, text: text)
        }
    }
    
    @ViewBuilder var ios: some View {
        standard
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(5.0)
            .padding([.leading, .trailing])
    }
    
    init(_ placeholder: String, text: Binding<String>, secure: Bool = false) {
        self.placeholder = placeholder
        self.text = text
        self.secure = secure
    }
}
