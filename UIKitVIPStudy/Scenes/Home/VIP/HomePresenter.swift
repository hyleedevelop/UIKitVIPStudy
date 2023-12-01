//
//  HomePresenter.swift
//  UIKitVIPStudy
//
//  Created by Eric on 11/30/23.
//

import Foundation

//MARK: - 프로토콜 선언

/// Interactor -> Presenter 통신을 위해 준수해야 하는 프로토콜
typealias HomeScenePresenterInput = HomeSceneInteractorOutput

/// Presenter -> ViewController 통신을 위해 준수해야 하는 프로토콜
protocol HomeScenePresenterOutput: AnyObject {
    func displayUserProfile(user: HomeModel.FetchUserInfo.ViewModel)
}

//MARK: - 속성 선언

final class HomePresenter {
    
    weak var viewController: HomeScenePresenterOutput?
    
    /// ListPresenter의 인스턴스를 생성
    /// - Parameter viewController: Presenter와 통신하는 ViewController
    init(viewController: HomeScenePresenterOutput) {
        self.viewController = viewController
    }
    
}

//MARK: - 내부 메서드 구현

extension HomePresenter {
    
}

//MARK: - Interactor -> Presenter 통신

extension HomePresenter: HomeScenePresenterInput {
    
    /// 네트워킹을 통해 받아온 깃허브 사용자 정보를
    /// ViewModel 포맷으로 변환 후 ViewController에 나타내기
    /// - Parameter user: 네트워킹을 통해 받아온 깃허브 사용자 정보 데이터
    func convertUserInfo(userInfo: HomeModel.FetchUserInfo.Response?) {
        guard let userInfo = userInfo else { return }
        let viewModel = HomeModel.FetchUserInfo.ViewModel(
            imageURL: userInfo.avatarUrl,
            id: userInfo.login
        )
        
        self.viewController?.displayUserProfile(user: viewModel)
    }
    
}
