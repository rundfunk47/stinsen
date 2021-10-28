//
//  API.swift
//  MVVM (iOS)
//
//  Created by Narek Mailian on 2021-10-28.
//

import Foundation

protocol API {
    func login(username: String, password: String) async throws
}
