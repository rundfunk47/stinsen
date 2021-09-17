import Foundation
import SwiftUI

struct RoundedButton: View {
    enum Style: Equatable {
        case primary
        case secondary
        case tertiary
    }
    
    let title: String
    var action: () -> Void
    let style: Style
    
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
        Button(title) {
            action()
        }
    }
    
    var ios: some View {
        Button(action: action, label: {
            HStack {
                Spacer()
                Text(title).font(.headline)
                Spacer()
            }
            .foregroundColor(foregroundColor)
            .padding()
            .background(backgroundColor)
            .cornerRadius(15.0)
            .frame(maxWidth: 300, minHeight: 50)
        })
    }
    
    var foregroundColor: Color {
        switch style {
        case .primary:
            return .white
        case .secondary:
            return .black
        case .tertiary:
            return Color("AccentColor")
        }
    }
    
    var backgroundColor: Color {
        switch style {
        case .primary:
            return Color("AccentColor")
        case .secondary:
            return Color(red: 0.8, green: 0.8, blue: 0.8)
        case .tertiary:
            return Color.clear
        }
    }
    
    init(
        _ title: String,
        style: Style = .primary,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.style = style
        self.action = action
    }
}
