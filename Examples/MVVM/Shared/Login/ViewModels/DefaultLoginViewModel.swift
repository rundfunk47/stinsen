//
//  DefaultLoginViewModel.swift
//  MVVM (iOS)
//
//  Created by Narek Mailian on 2021-10-28.
//

import Foundation
import Stinsen

final class DefaultLoginViewModel: LoginViewModel {
    @Published var username: String = ""
    @Published var password: String = ""
    
    // You have two ways of performing routing here. The first one is to use the RouterStore, which is what we're using in this example. The second one is by injecting the coordinator, either in init or by using a dependency injection framework. Using a dependency injection framework is recommended over using RouterObject, since you get a lot more flexibility and features that way.
    
    @RouterObject var router: NavigationRouter<LoginCoordinator>!
    
    fileprivate let api: API
    
    func login() async throws {
        try await api.login(username: username, password: password)
        router.coordinator.routeToAuthenticated()
    }
    
    init(api: API) {
        self.api = api
    }
}
