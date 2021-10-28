//
//  LoginViewModel.swift
//  MVVM (iOS)
//
//  Created by Narek Mailian on 2021-10-28.
//

import Foundation

protocol LoginViewModel: ObservableObject {
    var username: String { get set }
    var password: String { get set }
    func login() async throws
}
