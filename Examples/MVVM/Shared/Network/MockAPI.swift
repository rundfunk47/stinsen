//
//  MockAPI.swift
//  MVVM (iOS)
//
//  Created by Narek Mailian on 2021-10-28.
//

import Foundation

class MockAPI: API {
    var error: Error?
    
    func login(username: String, password: String) async throws {
        // Let's pretend this is a real network call being made here
        try await Task.sleep(nanoseconds: 2_000_000_000)

        if let error = error {
            throw error
        }
    }
}
