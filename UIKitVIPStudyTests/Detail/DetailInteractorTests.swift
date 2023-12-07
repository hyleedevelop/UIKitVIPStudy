//
//  DetailInteractorTests.swift
//  UIKitVIPStudyTests
//
//  Created by Eric on 12/4/23.
//

import XCTest
@testable import UIKitVIPStudy

// MARK: - ViewController 모듈 검증

final class DetailInteractorTests: XCTestCase {

    /// 테스트 진행 전 기본값 설정
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    /// 테스트 진행 후 초기 상태로 돌려놓기
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    /// **Presenter**의 `convertResponseFormatCalled` 메서드를
    /// 정상적으로 호출하는지에 대한 테스트
    func testInteractorShouldAskPresenterToConvertResponseFormat() {
        // Given
        /// 이전 화면으로부터 저달받은 데이터
        let data = UserInfo(
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
        /// 네트워킹 요청에 사용할 **Model**
        let request = DetailModel.DisplayUserInfoDetails.Request.init(data: data)
        /// 테스트용 가짜 **Presenter**
        let mockPresenter = MockDetailPresenter()
        /// 실제 프로젝트에 사용할 **Interactor** (검증 대상)
        let interactor = DetailInteractor(presenter: mockPresenter)
        
        // When
        interactor.passUserInfoToPresenter(request: request)
        
        // Then
        XCTAssertTrue(mockPresenter.isConvertResponseFormatCalled)
    }

}

//MARK: - MockDetailPresenter 정의

final class MockDetailPresenter: DetailPresentationLogic {
    
    // 해당 메서드의 호출 여부
    var isConvertResponseFormatCalled = false
    
    // **Interactor** -> **Presenter** 통신을 위해 구현해야 하는 메서드 목록
    func convertResponseFormat(userInfoDetails: UserInfo?) {
        self.isConvertResponseFormatCalled = true
    }

}
