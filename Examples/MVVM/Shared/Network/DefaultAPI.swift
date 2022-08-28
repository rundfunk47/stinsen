//
//  DefaultAPI.swift
//  MVVM (iOS)
//
//  Created by Narek Mailian on 2021-10-28.
//

import Foundation

struct PasswordError: LocalizedError {
    var errorDescription: String? {
        return "Wrong password or username"
    }
}

class DefaultAPI: API {
    func login(username: String, password: String) async throws {
        // Let's pretend this is a real network call being made here
        try await Task.sleep(nanoseconds: 2_000_000_000)
        if username == "user@example.com" && password == "password" {
            return
        } else {
            throw PasswordError()
        }
    }
}
