//
//  DetailViewControllerTests.swift
//  UIKitVIPStudyTests
//
//  Created by Eric on 12/4/23.
//

import XCTest
@testable import UIKitVIPStudy

// MARK: - ViewController 모듈 검증

final class DetailViewControllerTests: XCTestCase {
    
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
        /// 이전 화면으로부터 전달받은 데이터
        let dataToReceive = UserInfo(
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
        /// 실제 프로젝트에 사용할 **Configurator**
        let configurator = DetailConfigurator.shared
        /// 실제 프로젝트에 사용할 **ViewController** (검증 대상)
        let viewController = DetailViewController(
            dataToReceive: dataToReceive, 
            configurator: configurator
        )
        
        // Then
        XCTAssertNotNil(viewController.router)
    }
    
    /// **ViewController**가 **Interactor**를 정상적으로 참조하는지에 대한 테스트
    func testViewControllerShouldInitializeInteractor() {
        // Given
        /// 이전 화면으로부터 전달받은 데이터
        let dataToReceive = UserInfo(
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
        /// 실제 프로젝트에 사용할 **Configurator**
        let configurator = DetailConfigurator.shared
        /// 실제 프로젝트에 사용할 **ViewController** (검증 대상)
        let viewController = DetailViewController(
            dataToReceive: dataToReceive,
            configurator: configurator
        )
        
        // Then
        XCTAssertNotNil(viewController.interactor)
    }
    
    /// **Router**가 **ViewController**를 정상적으로 참조하는지에 대한 테스트
    func testRouterShouldInitializeViewController() {
        // Given
        /// 이전 화면으로부터 저달받은 데이터
        let dataToReceive = UserInfo(
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
        /// 실제 프로젝트에 사용할 **Configurator**
        let configurator = DetailConfigurator.shared
        /// 실제 프로젝트에 사용할 **ViewController** (검증 대상)
        let viewController = DetailViewController(
            dataToReceive: dataToReceive,
            configurator: configurator
        )
        
        // Then
        XCTAssertEqual(viewController.router.viewController, viewController)
    }
    
    /// **Presenter**에 이전 화면에서 받아온 사용자 정보를 전달하기 위해
    /// **ViewController**에서 **Interactor**의 `passUserInfoToPresenter` 메서드를
    /// 정상적으로 호출하는지에 대한 테스트
    func testViewControllerShouldAskInteractorToPassUserInfoToPresenter() {
        // Given
        /// 이전 화면으로부터 저달받은 데이터
        let dataToReceive = UserInfo(
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
        /// 가짜 **Interactor**
        let mockInteractor = MockDetailInteractor()
        /// 실제 프로젝트에 사용할 **Configurator**
        let configurator = DetailConfigurator.shared
        /// 실제 프로젝트에 사용할 **ViewController** (검증 대상)
        let viewController = DetailViewController(
            dataToReceive: dataToReceive,
            configurator: configurator
        )
        
        // When
        viewController.interactor = mockInteractor
        viewController.dataReceivedFromPreviousScene()
        
        // Then
        XCTAssertTrue(mockInteractor.isPassUserInfoToPresenterCalled)
    }
    
    /// 화면 전환을 위해 **ViewController**에서 **Router**의
    /// `navigateToDetail` 메서드를 정상적으로 호출하는지에 대한 테스트
    func testViewControllerShouldAskRouterToNavigateToGithub() {
        // Given
        /// 이전 화면으로부터 저달받은 데이터
        let dataToReceive = UserInfo(
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
        let mockRouter = MockDetailRouter()
        /// 실제 프로젝트에 사용할 **Configurator**
        let configurator = DetailConfigurator.shared
        /// 실제 프로젝트에 사용할 **ViewController** (검증 대상)
        let viewController = DetailViewController(
            dataToReceive: dataToReceive,
            configurator: configurator
        )
        
        // When
        viewController.router = mockRouter
        viewController.visitButtonTapped()
        
        // Then
        XCTAssertTrue(mockRouter.isNavigateToGithubCalled)
    }
    
}

//MARK: - MockDetailInteractor 정의

final class MockDetailInteractor: DetailBusinessLogic {
    
    // 해당 메서드의 호출 여부
    var isPassUserInfoToPresenterCalled = false
    
    // **ViewController** -> **Interactor** 통신을 위해 구현해야 하는 메서드 목록
    func passUserInfoToPresenter(request: DetailModel.DisplayUserInfoDetails.Request) {
        self.isPassUserInfoToPresenterCalled = true
    }
    
}

//MARK: - MockDetailRouter 정의

final class MockDetailRouter: DetailRoutingLogic {
    
    // 해당 메서드의 호출 여부
    var isNavigateToGithubCalled = false
    
    // **ViewController** -> **Router** 통신을 위해 구현해야 하는 속성 목록
    var viewController: DetailViewController?
    
    // **ViewController** -> **Router** 통신을 위해 구현해야 하는 메서드 목록
    func navigateToGithub(userID: String) {
        self.isNavigateToGithubCalled = true
    }
    
}
