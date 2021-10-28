//
//  MockLoginCoordinator.swift
//  MVVM (iOS)
//
//  Created by Narek Mailian on 2021-10-28.
//

import Foundation

final class MockLoginCoordinator: LoginCoordinator {
    var routed: Bool = false
    
    func routeToAuthenticated() {
        self.routed = true
    }
}
