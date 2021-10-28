//
//  MVVMTests.swift
//  MVVMTests
//
//  Created by Narek Mailian on 2021-10-28.
//

import XCTest
@testable import MVVM

import Stinsen

class MVVMTests: XCTestCase {

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    func testLoginSuccessfulViewModel() async throws {
        let mockAPI = MockAPI()
        let mockCoordinator = MockLoginCoordinator()
        
        XCTAssert(!mockCoordinator.routed)
        
        let mockNavigationRouter = NavigationRouter(id: 0, coordinator: mockCoordinator as LoginCoordinator)
        
        RouterStore.shared.store(router: mockNavigationRouter)
        
        let loginViewModel = DefaultLoginViewModel(api: mockAPI)
        
        try await loginViewModel.login()
        
        XCTAssert(mockCoordinator.routed)
    }
}
