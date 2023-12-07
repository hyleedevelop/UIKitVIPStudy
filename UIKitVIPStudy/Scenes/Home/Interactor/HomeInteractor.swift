//
//  ListInteractor.swift
//  UIKitVIPStudy
//
//  Created by Eric on 11/30/23.
//

import Foundation

//MARK: - 프로토콜 선언

/// **Interactor** -> **Presenter** 통신을 위해 준수해야 하는 프로토콜
protocol HomePresentationLogic: AnyObject {
    func convertResponseFormat(response: HomeModel.FetchUserInfo.Response?)
    func passFailStatus()
}

/// Networking 로직을 수행하기 위해 준수해야 하는 프로토콜
protocol HomeNetworkingLogic: AnyObject {
    func startFetching(with request: HomeModel.FetchUserInfo.Request) async throws -> HomeModel.FetchUserInfo.Response
}

//MARK: - 속성 선언 및 초기화

/// 화면의 비즈니스 로직을 담당하는 객체
class HomeInteractor {
    
    /// **Presenter**
    var presenter: HomePresentationLogic?
    /// **NetworkingWorker**
    let networkingWorker: HomeNetworkingLogic
    
    var response: HomeModel.FetchUserInfo.Response?
    
    /// **Interactor**의 인스턴스를 생성
    /// - Parameters:
    ///   - presenter: Interactor와 통신하는 Presenter
    ///   - networkingWorker: 사용자 정보를 네트워킹으로 가져오기 위한 Worker
    init(presenter: HomePresentationLogic, networkingWorker: HomeNetworkingLogic = HomeNetworkingWorker()) {
        self.presenter = presenter
        self.networkingWorker = networkingWorker
    }
    
}

//MARK: - ViewController -> Interactor 통신

extension HomeInteractor: HomeBusinessLogic {
    
    /// 네트워킹을 통해 깃허브 사용자 정보를 비동기적으로 가져오기
    func fetchUserInfo(request: HomeModel.FetchUserInfo.Request) {
        Task {
            /// 성공
            do {
                // 네트워킹 종료까지 기다렸다가 받아온 데이터를 **presenter**에게 전달
                self.response = try await self.networkingWorker.startFetching(with: request)
                self.presenter?.convertResponseFormat(response: self.response)
            }
            
            /// 실패: 올바르지 않은 URL
            catch NetworkingError.invalidURL {
                print(NetworkingError.invalidURL)
                self.presenter?.passFailStatus()
            } 
            
            /// 실패: 올바르지 않은 응답
            catch NetworkingError.invalidResponse {
                print(NetworkingError.invalidResponse)
                self.presenter?.passFailStatus()
            } 
            
            /// 실패: 올바르지 않은 데이터
            catch NetworkingError.invalidData {
                print(NetworkingError.invalidData)
                self.presenter?.passFailStatus()
            }
            
            /// 실패: 기타 예상치 못한 원인
            catch {
                print("Unexpected error")
                self.presenter?.passFailStatus()
            }
        }
    }
    
}
