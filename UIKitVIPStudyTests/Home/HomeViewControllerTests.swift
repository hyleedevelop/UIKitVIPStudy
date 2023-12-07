//
//  HomeViewControllerTests.swift
//  UIKitVIPStudyTests
//
//  Created by Eric on 12/3/23.
//

import XCTest
@testable import UIKitVIPStudy

// MARK: - ViewController 모듈 검증

final class HomeViewControllerTests: XCTestCase {

    private var window: UIWindow!
    
    /// 테스트 진행 전 기본값 설정
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        self.window = UIWindow()
    }
    
    /// 테스트 진행 후 초기 상태로 돌려놓기
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        self.window = nil
    }
    
    /// **ViewController**가 **Router**를 정상적으로 참조하는지에 대한 테스트
    func testViewControllerShouldInitializeRouter() {
        // Given
        /// 실제 프로젝트에 사용할 **Configurator**
        let configurator = HomeConfigurator.shared
        /// 실제 프로젝트에 사용할 **ViewController** (검증 대상)
        let viewController = HomeViewController(configurator: configurator)
        
        // Then
        XCTAssertNotNil(viewController.router)
    }
    
    /// **ViewController**가 **Interactor**를 정상적으로 참조하는지에 대한 테스트
    func testViewControllerShouldInitializeInteractor() {
        // Given
        /// 실제 프로젝트에 사용할 **Configurator**
        let configurator = HomeConfigurator.shared
        /// 실제 프로젝트에 사용할 **ViewController** (검증 대상)
        let viewController = HomeViewController(configurator: configurator)
        
        // Then
        XCTAssertNotNil(viewController.interactor)
    }
    
    /// **Router**가 **ViewController**를 정상적으로 참조하는지에 대한 테스트
    func testRouterShouldInitializeViewController() {
        // Given
        /// 실제 프로젝트에 사용할 **Configurator**
        let configurator = HomeConfigurator.shared
        /// 실제 프로젝트에 사용할 **ViewController** (검증 대상)
        let viewController = HomeViewController(configurator: configurator)
        
        // Then
        XCTAssertEqual(viewController.router.viewController, viewController)
    }
    
    /// 네트워킹을 시도하기 위해 **ViewController**에서 **Interactor**의
    /// `fetchUserInfo` 메서드를 정상적으로 호출하는지에 대한 테스트
    func testViewControllerShouldAskInteractorToFetchUserInfo() {
        // Given
        /// 가짜 Interactor
        let mockInteractor = MockHomeInteractor()
        /// 실제 프로젝트에 사용할 Configurator
        let configurator = HomeConfigurator.shared
        /// 실제 프로젝트에 사용할 ViewController (검증 대상)
        let viewController = HomeViewController(configurator: configurator)
        
        // When
        viewController.interactor = mockInteractor
        viewController.searchButtonTapped(input: "abc")
        
        // Then
        XCTAssertTrue(mockInteractor.isFetchUserInfoCalled)
    }
    
    /// 화면 전환을 위해 **ViewController**에서 **Router**의
    /// `navigateToDetail` 메서드를 정상적으로 호출하는지에 대한 테스트
    func testViewControllerShouldAskRouterToNavigateToDetail() {
        // Given
        /// 전달할 데이터
        let dataToPass = UserInfo(
            imageURL: "https://avatars.githubusercontent.com/u/115394709?v=4",
            id: "hyleedevelop",
            name: "Hoyeon Lee",
            bio: "Dreaming of being an iOS developer...",
            location: "South Korea",
            publicRepositories: 6,
            publicGists: 8,
            followers: 1,
            following: 3
        )
        /// 가짜 **Router**
        let mockRouter = MockHomeRouter()
        /// 실제 프로젝트에 사용할 **Configurator**
        let configurator = HomeConfigurator.shared
        /// 실제 프로젝트에 사용할 **ViewController** (검증 대상)
        let viewController = HomeViewController(configurator: configurator)
        
        // When
        viewController.router = mockRouter
        viewController.router.navigateToDetail(dataToPass: dataToPass, animated: true)
        
        // Then
        XCTAssertTrue(mockRouter.isNavigateToDetailCalled)
    }

}

//MARK: - MockHomeInteractor 정의

final class MockHomeInteractor: HomeBusinessLogic {
    
    // 해당 메서드의 호출 여부
    var isFetchUserInfoCalled = false
    
    // **ViewController** -> **Interactor** 통신을 위해 구현해야 하는 속성 목록
    var response: HomeModel.FetchUserInfo.Response?
    
    // **ViewController** -> **Interactor** 통신을 위해 구현해야 하는 메서드 목록
    func fetchUserInfo(request: HomeModel.FetchUserInfo.Request) {
        self.isFetchUserInfoCalled = true
    }
    
}

//MARK: - MockHomeRouter 정의

final class MockHomeRouter: HomeRoutingLogic {
    
    // 해당 메서드의 호출 여부
    var isNavigateToDetailCalled = false
    
    // **ViewController** -> **Router** 통신을 위해 구현해야 하는 속성 목록
    var viewController: HomeViewController?
    
    // **ViewController** -> **Router** 통신을 위해 구현해야 하는 메서드 목록
    func navigateToDetail(dataToPass: UserInfo, animated: Bool) {
        self.isNavigateToDetailCalled = true
    }
    
}
