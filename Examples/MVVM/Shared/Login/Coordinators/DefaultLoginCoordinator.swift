//
//  LoginCoordinator.swift
//  MVVM (iOS)
//
//  Created by Narek Mailian on 2021-10-28.
//

import Foundation
import SwiftUI
import Stinsen

final class DefaultLoginCoordinator: LoginCoordinator, NavigationCoordinatable {
    var stack: NavigationStack<DefaultLoginCoordinator> = NavigationStack(initial: \.start)
    @Root var start = makeStart
    @Root var authenticated = makeAuthenticated
    
    // This is used to define which protocol that should be used when storing the router. It's used together with @RouterObject in DefaultLoginViewModel. If you don't use RouterObject, or if you do not need a protocol for LoginCoordinator, this can be removed.
    
    lazy var routerStorable: LoginCoordinator = self
    
    private let api = DefaultAPI()
    
    func makeStart() -> some View {
        return LoginView(viewModel: DefaultLoginViewModel(api: api))
    }
    
    func makeAuthenticated() -> DefaultAuthenticatedCoordinator {
        return DefaultAuthenticatedCoordinator()
    }
    
    func routeToAuthenticated() {
        self.root(\.authenticated)
    }
}
