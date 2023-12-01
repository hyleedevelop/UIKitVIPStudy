//
//  ListInteractor.swift
//  UIKitVIPStudy
//
//  Created by Eric on 11/30/23.
//

import Foundation

//MARK: - 프로토콜 선언

/// Viewcontroller -> Interactor 통신을 위해 준수해야 하는 프로토콜
typealias HomeSceneInteractorInput = HomeSceneViewControllerOutput

/// Interactor -> Presenter 통신을 위해 준수해야 하는 프로토콜
protocol HomeSceneInteractorOutput: AnyObject {
    func convertResponseFormat(response: HomeModel.FetchUserInfo.Response?)
    func passFailStatus()
}

//MARK: - 속성 선언

final class HomeInteractor {
    
    var presenter: HomeSceneInteractorOutput?
    let networkingWorker: HomeNetworkingWorker
    
    var response: HomeModel.FetchUserInfo.Response?
    
    /// Interactor의 인스턴스를 생성
    /// - Parameters:
    ///   - presenter: Interactor와 통신하는 Presenter
    ///   - networkingWorker: 사용자 정보를 네트워킹으로 가져오기 위한 Worker
    init(presenter: HomeSceneInteractorOutput, networkingWorker: HomeNetworkingWorker = HomeNetworkingWorker()) {
        self.presenter = presenter
        self.networkingWorker = networkingWorker
    }
    
}

//MARK: - 내부 메서드 구현

extension HomeInteractor {
    
}

//MARK: - ViewController -> Interactor 통신

extension HomeInteractor: HomeSceneInteractorInput {
    
    /// 네트워킹을 통해 깃허브 사용자 정보를 비동기적으로 가져오기
    func fetchUserInfo(request: HomeModel.FetchUserInfo.Request) {
        Task {
            /// 성공
            do {
                // 네트워킹 종료까지 기다렸다가 받아온 데이터를 presenter에게 전달
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
