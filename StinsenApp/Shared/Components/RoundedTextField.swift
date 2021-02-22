import Foundation
import SwiftUI

struct RoundedTextField: View {
    let placeholder: String
    var text: Binding<String>
    
    var body: some View {
        #if os(iOS)
        ios
        #elseif os(macOS)
        standard
        #elseif os(watchOS)
        standard
        #elseif os(tvOS)
        standard
        #else
        standard
        #endif
    }
    
    var standard: some View {
        TextField(placeholder, text: text)
    }
    
    var ios: some View {
        TextField(placeholder, text: text)
            .padding()
            .background(Color.init(red: 0.9, green: 0.9, blue: 0.9))
            .cornerRadius(5.0)
            .padding([.leading, .trailing])
    }
    
    init(_ placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self.text = text
    }
}
