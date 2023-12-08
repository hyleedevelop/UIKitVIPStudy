//
//  HomePresenter.swift
//  UIKitVIPStudy
//
//  Created by Eric on 11/30/23.
//

import Foundation

//MARK: - 프로토콜 선언

/// **Presenter** -> **ViewController** 통신을 위해 준수해야 하는 프로토콜
protocol HomeDisplayLogic: AnyObject {
    func displayUserProfile(viewModel: HomeModel.FetchUserInfo.ViewModel)
    func displayFailStatus()
    func prepareDataToPass(dataToPass: UserInfo)
}

//MARK: - 속성 선언

/// 화면에 표시할 데이터를 담당하는 객체
class HomePresenter {
    
    weak var viewController: HomeDisplayLogic?
    
    /// ListPresenter의 인스턴스를 생성
    /// - Parameter viewController: Presenter와 통신하는 ViewController
    init(viewController: HomeDisplayLogic) {
        self.viewController = viewController
    }
    
}

//MARK: - 내부 메서드 구현

extension HomePresenter {
    
}

//MARK: - Interactor -> Presenter 통신

extension HomePresenter: HomePresentationLogic {
    
    /// 네트워킹을 통해 받아온 깃허브 사용자 정보를
    /// 뷰모델 포맷으로 변환 후 **ViewController**에 전달
    /// (현재 화면에 표시할 데이터 + 다음 화면에 넘길 데이터)
    /// - Parameter userInfo: 네트워킹을 통해 받아온 깃허브 사용자 정보 데이터
    func convertResponseFormat(response: HomeModel.FetchUserInfo.Response?) {
        guard let response = response else {
            self.viewController?.displayFailStatus()
            return
        }
        
        let viewModel = HomeModel.FetchUserInfo.ViewModel(
            imageURL: response.avatarUrl,
            id: response.login
        )
        
        let dataToPass = UserInfo(
            imageURL: response.avatarUrl,
            id: response.login,
            name: response.name,
            bio: response.bio,
            location: response.location,
            publicRepositories: response.publicRepos,
            publicGists: response.publicGists,
            followers: response.followers,
            following: response.following
        )
        
        self.viewController?.displayUserProfile(viewModel: viewModel)
        self.viewController?.prepareDataToPass(dataToPass: dataToPass)
    }
    
    /// 네트워킹이 실패해서 뷰모델 포맷으로 변환할 수 없는 상태임을 **ViewController**에 전달
    func passFailStatus() {
        self.viewController?.displayFailStatus()
    }
    
}
