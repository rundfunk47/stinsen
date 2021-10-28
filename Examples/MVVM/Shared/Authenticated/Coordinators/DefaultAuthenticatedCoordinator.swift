//
//  DefaultAuthenticatedCoordinator.swift
//  MVVM (iOS)
//
//  Created by Narek Mailian on 2021-10-28.
//

import Foundation
import SwiftUI
import Stinsen

final class DefaultAuthenticatedCoordinator: AuthenticatedCoordinator, NavigationCoordinatable {
    var stack = NavigationStack(initial: \DefaultAuthenticatedCoordinator.start)
    @Root var start = makeStart
    
    func makeStart() -> some View {
        AuthenticatedView()
    }
}
