//
//  HomeInteractorTests.swift
//  HomeInteractorTests
//
//  Created by Eric on 12/3/23.
//

import XCTest
@testable import UIKitVIPStudy

// MARK: - Interactor 모듈 검증

final class HomeInteractorTests: XCTestCase {
    
    /// 테스트 진행 전 기본값 설정
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    /// 테스트 진행 후 초기 상태로 돌려놓기
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    /// 네트워킹을 위해 **Interactor**에서 **NetworkingWorker**의
    /// `fetchUserInfo` 메서드를 정상적으로 호출하는지에 대한 테스트
    func testInteractorShouldAskNetworkingWorkerToFetchUserInfo() {
        // Given
        /// 네트워킹 요청에 사용할 **Model**
        let request = HomeModel.FetchUserInfo.Request.init(id: "MockID")
        /// 테스트용 가짜 **NetworkingWorker**
        let mockNetworkingWorker = MockHomeNetworkingWorker()
        /// 테스트용 가짜 **Presenter**
        let mockPresenter = MockHomePresenter()
        /// 실제 프로젝트에 사용할 **Interactor** (검증 대상)
        let interactor = HomeInteractor(
            presenter: mockPresenter,
            networkingWorker: mockNetworkingWorker
        )
        
        // 네트워킹 작업이 오래 걸리기 때문에 동일한 메인큐에서 실행되도록 작성
        // 이렇게 하지 않으면 `self.isFetchingSuccessful = true`가 실행되기 전에
        // `XCTAssertTrue` 메서드가 먼저 실행되어서 항상 테스트 실패가 발생함
        DispatchQueue.main.async {
            // When
            interactor.fetchUserInfo(request: request)
        
            // Then
            XCTAssertTrue(mockNetworkingWorker.isFetchingSuccessful)
        }
    }
    
    /// 네트워킹에 성공했을 때 **Presenter**의
    /// `convertResponseFormatCalled` 메서드를 정상적으로 호출하는지에 대한 테스트
    func testInteractorShouldAskPresenterToConvertResponseFormat() {
        // Given
        /// 네트워킹 요청에 사용할 **Model**
        let request = HomeModel.FetchUserInfo.Request.init(id: "MockID")
        /// 테스트용 가짜 **NetworkingWorker**
        let mockNetworkingWorker = MockHomeNetworkingWorker()
        /// 테스트용 가짜 **Presenter**
        let mockPresenter = MockHomePresenter()
        /// 실제 프로젝트에 사용할 **Interactor** (검증 대상)
        let interactor = HomeInteractor(
            presenter: mockPresenter,
            networkingWorker: mockNetworkingWorker
        )
        
        // 네트워킹 작업이 오래 걸리기 때문에 동일한 메인큐에서 실행되도록 작성
        // 이렇게 하지 않으면 `self.isFetchingSuccessful = true`가 실행되기 전에
        // `XCTAssertTrue` 메서드가 먼저 실행되어서 항상 테스트 실패가 발생함
        DispatchQueue.main.async {
            // When
            interactor.fetchUserInfo(request: request)
            
            // Then
            XCTAssertTrue(mockPresenter.isConvertResponseFormatCalled)
            XCTAssertFalse(mockPresenter.isPassFailStatusCalled)
        }
    }
    
    /// 네트워킹에 실패했을 때 **Presenter**의
    /// `passFailStatus` 메서드를 정상적으로 호출하는지에 대한 테스트
    func testInteractorShouldAskPresenterToPassFailStatus() {
        // Given
        /// 네트워킹 요청에 사용할 **Model**
        let request = HomeModel.FetchUserInfo.Request.init(id: "MockID")
        /// 테스트용 가짜 **NetworkingWorker**
        let mockNetworkingWorker = MockHomeNetworkingWorker()
        /// 테스트용 가짜 **Presenter**
        let mockPresenter = MockHomePresenter()
        /// 실제 프로젝트에 사용할 Interactor** (검증 대상)
        let interactor = HomeInteractor(
            presenter: mockPresenter,
            networkingWorker: mockNetworkingWorker
        )
        
        // 네트워킹 작업이 오래 걸리기 때문에 동일한 메인큐에서 실행되도록 작성
        // 이렇게 하지 않으면 `self.isFetchingSuccessful = true`가 실행되기 전에
        // `XCTAssertTrue` 메서드가 먼저 실행되어서 항상 테스트 실패가 발생함
        DispatchQueue.main.async {
            // When
            mockNetworkingWorker.isFetchingFailed = true
            interactor.fetchUserInfo(request: request)
            
            // Then
            XCTAssertTrue(mockPresenter.isPassFailStatusCalled)
            XCTAssertFalse(mockPresenter.isConvertResponseFormatCalled)
        }
    }
    
}

//MARK: - MockHomeNetworkingWorker 정의

final class MockHomeNetworkingWorker: HomeNetworkingLogic {
    
    // 해당 메서드의 호출 여부
    var isFetchingSuccessful = false
    var isFetchingFailed = false
    
    // 네트워킹 에러의 종류
    enum FetchError: Error {
        case someError
    }
    
    // **Interactor** -> **NetworkingWorker** 통신을 위해 구현해야 하는 메서드 목록
    func startFetching(with request: HomeModel.FetchUserInfo.Request) async throws -> HomeModel.FetchUserInfo.Response {
        // 사용자 정보를 네트워킹으로 받아오는 메서드가 호출되었다고 가정
        self.isFetchingSuccessful = true
        
        // 네트워킹 결과에 따른 처리
        if self.isFetchingFailed {
            throw FetchError.someError
        } else {
            return HomeModel.FetchUserInfo.Response.init(
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
        }
    }
    
}

//MARK: - MockHomePresenter 정의

final class MockHomePresenter: HomePresentationLogic {
    
    // 해당 메서드의 호출 여부
    var isConvertResponseFormatCalled = false
    var isPassFailStatusCalled = false
    
    // **Interactor** -> **Presenter** 통신을 위해 구현해야 하는 메서드 목록
    func convertResponseFormat(response: HomeModel.FetchUserInfo.Response?) {
        self.isConvertResponseFormatCalled = true
    }

    func passFailStatus() {
        self.isPassFailStatusCalled = true
    }
    
}
