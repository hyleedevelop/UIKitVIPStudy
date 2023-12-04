//
//  DetailPresenterTests.swift
//  UIKitVIPStudyTests
//
//  Created by Eric on 12/4/23.
//

import XCTest
@testable import UIKitVIPStudy

// MARK: - ViewController 모듈 검증

final class DetailPresenterTests: XCTestCase {

    /// 테스트 진행 전 기본값 설정
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    /// 테스트 진행 후 초기 상태로 돌려놓기
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    /// 테이블뷰를 업데이트 하기 위해 **Presenter**에서 **ViewController**의
    /// `displayUserDetail` 메서드를 정상적으로 호출하는지에 대한 테스트
    func testPresenterShouldAskViewControllerTodisplayUserDetail() {
        // Given
        /// 네트워킹 요청 결과로 받아오는 데이터의 **Model**
        let userInfoDetails = UserInfo(
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
        /// 가짜 **ViewController**
        let mockViewController = MockDetailViewController()
        /// 실제 프로젝트에 사용할 **Presenter** (검증 대상)
        let presenter = DetailPresenter(viewController: mockViewController)
        
        // When
        presenter.convertResponseFormat(userInfoDetails: userInfoDetails)
        
        // Then
        XCTAssertTrue(mockViewController.isDisplayUserDetailCalled)
    }

}

//MARK: - MockDetailViewController 정의

final class MockDetailViewController: DetailPresenterOutput {
    
    // 해당 메서드의 호출 여부
    var isDisplayUserDetailCalled = false
    
    // **Presenter** -> **ViewController** 통신을 위해 구현해야 하는 메서드 목록
    func displayUserDetail(viewModel: DetailModel.DisplayUserInfoDetails.ViewModel) {
        self.isDisplayUserDetailCalled = true
    }
    
}
