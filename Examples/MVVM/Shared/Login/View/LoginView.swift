//
//  LoginView.swift
//  MVVM (iOS)
//
//  Created by Narek Mailian on 2021-10-28.
//

import SwiftUI

struct LoginView<ViewModel: LoginViewModel>: View {
    @ObservedObject var viewModel: ViewModel
    @State var error: Error?
    @State var loggingIn: Bool = false
    
    var body: some View {
        VStack {
            TextField("Username", text: $viewModel.username)
                .textInputAutocapitalization(.never)
                .textContentType(.username)
                .disableAutocorrection(true)
                .keyboardType(.emailAddress)
            SecureField("Password", text: $viewModel.password)
            if let error = error {
                Text(error.localizedDescription)
                    .foregroundColor(.red)
            }
            if loggingIn {
               ProgressView()
            } else {
                Button("Login") {
                    loggingIn = true
                    Task {
                        do {
                            try await viewModel.login()
                        } catch {
                            self.error = error
                        }
                        loggingIn = false
                    }
                }
            }
        }
    }
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: MockLoginViewModel())
    }
}
