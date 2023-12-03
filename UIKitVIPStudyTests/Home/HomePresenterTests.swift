//
//  HomePresenterTests.swift
//  UIKitVIPStudyTests
//
//  Created by Eric on 12/3/23.
//

import XCTest
@testable import UIKitVIPStudy

// MARK: - Presenter 모듈 검증

final class HomePresenterTests: XCTestCase {

    /// 테스트 진행 전 기본값 설정
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    /// 테스트 진행 후 초기 상태로 돌려놓기
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    /// 네트워킹에 성공하여 UI를 업데이트 하기 위해 **Presenter**에서 **ViewController**의
    /// `displayUserProfile` 메서드를 정상적으로 호출하는지에 대한 테스트
    func testPresenterShouldAskViewControllerTodisplayUserProfile() {
        // Given
        /// 가짜 ViewController
        let mockViewController = MockHomeViewController()
        /// 실제 프로젝트에 사용할 Presenter (검증 대상)
        let presenter = HomePresenter(viewController: mockViewController)
        /// 네트워킹 요청 결과로 받아오는 데이터의 **Model**
        let response = HomeModel.FetchUserInfo.Response(
            avatarUrl: "https://avatars.githubusercontent.com/u/115394709?v=4",
            login: "hyleedevelop",
            name: "Hoyeon Lee",
            bio: "Dreaming of being an iOS developer...",
            location: "South Korea",
            publicRepos: 6,
            publicGists: 8,
            followers: 1,
            following: 3
        )
        
        // When
        presenter.convertResponseFormat(response: response)
        
        // Then
        XCTAssertTrue(mockViewController.isDisplayUserProfileCalled)
    }
    
    /// 네트워킹에 성공하여 Detail 화면으로 보낼 데이터를 전달하기 위해 **Presenter**에서
    /// **ViewController**의 `prepareDataToPass` 메서드를 정상적으로 호출하는지에 대한 테스트
    func testPresenterShouldAskViewControllerToprepareDataToPass() {
        // Given
        /// 가짜 ViewController
        let mockViewController = MockHomeViewController()
        /// 실제 프로젝트에 사용할 Presenter (검증 대상)
        let presenter = HomePresenter(viewController: mockViewController)
        /// 네트워킹 요청 결과로 받아오는 데이터의 **Model**
        let response = HomeModel.FetchUserInfo.Response(
            avatarUrl: "https://avatars.githubusercontent.com/u/115394709?v=4",
            login: "hyleedevelop",
            name: "Hoyeon Lee",
            bio: "Dreaming of being an iOS developer...",
            location: "South Korea",
            publicRepos: 6,
            publicGists: 8,
            followers: 1,
            following: 3
        )
        
        // When
        presenter.convertResponseFormat(response: response)
        
        // Then
        XCTAssertTrue(mockViewController.isPrepareDataToPassCalled)
    }
    
    /// 네트워킹에 실패하여 UI를 업데이트 하기 위해 **Presenter**에서 **ViewController**의
    /// `DisplayFailStatus` 메서드를 정상적으로 호출하는지에 대한 테스트
    func testPresenterShouldAskViewControllerToDisplayFailStatus() {
        // Given
        /// 가짜 ViewController
        let mockViewController = MockHomeViewController()
        /// 실제 프로젝트에 사용할 Presenter (검증 대상)
        let presenter = HomePresenter(viewController: mockViewController)
        
        // When
        presenter.passFailStatus()
        
        // Then
        XCTAssertTrue(mockViewController.isDisplayFailStatusCalled)
    }

}

//MARK: - MockHomeViewController 정의

final class MockHomeViewController: HomePresenterOutput {
    
    // 해당 메서드의 호출 여부
    var isDisplayUserProfileCalled = false
    var isDisplayFailStatusCalled = false
    var isPrepareDataToPassCalled = false
    
    // **Presenter** -> **ViewController** 통신을 위해 구현해야 하는 메서드 목록
    func displayUserProfile(viewModel: HomeModel.FetchUserInfo.ViewModel) {
        isDisplayUserProfileCalled = true
    }
    
    func displayFailStatus() {
        self.isDisplayFailStatusCalled = true
    }
    
    func prepareDataToPass(dataToPass: UserInfo) {
        self.isPrepareDataToPassCalled = true
    }
    
}
