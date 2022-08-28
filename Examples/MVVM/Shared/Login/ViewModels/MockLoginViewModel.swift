//
//  MockLoginViewModel.swift
//  MVVM (iOS)
//
//  Created by Narek Mailian on 2021-10-28.
//

import Foundation

final class MockLoginViewModel: LoginViewModel {
    @Published var username: String = ""
    @Published var password: String = ""
    
    var error: Error?
    
    func login() async throws {
        try await Task.sleep(nanoseconds: 2_000_000_000)
        
        if let error = error {
            throw error
        }
    }
    
    init() {

    }
}
