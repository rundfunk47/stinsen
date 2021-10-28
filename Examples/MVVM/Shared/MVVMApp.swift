//
//  MVVMApp.swift
//  Shared
//
//  Created by Narek Mailian on 2021-10-28.
//

import SwiftUI

@main
struct MVVMApp: App {
    var body: some Scene {
        WindowGroup {
            DefaultLoginCoordinator().view()
        }
    }
}
