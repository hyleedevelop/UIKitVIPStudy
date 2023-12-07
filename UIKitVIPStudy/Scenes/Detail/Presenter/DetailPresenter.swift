//
//  DetailPresenter.swift
//  UIKitVIPStudy
//
//  Created by Eric on 12/1/23.
//

import Foundation

//MARK: - 프로토콜 선언

/// **Presenter** -> **ViewController** 통신을 위해 준수해야 하는 프로토콜
protocol DetailDisplayLogic: AnyObject {
    func displayUserDetail(viewModel: DetailModel.DisplayUserInfoDetails.ViewModel)
}

//MARK: - 속성 선언

/// 화면에 표시할 데이터를 담당하는 객체
final class DetailPresenter {
    
    weak var viewController: DetailDisplayLogic?
    
    /// ListPresenter 인스턴스를 생성
    /// - Parameter viewController: presenter의 output
    init(viewController: DetailDisplayLogic) {
        self.viewController = viewController
    }
    
}

//MARK: - 내부 메서드 구현

extension DetailPresenter {
    
}

//MARK: - Interactor -> Presenter 통신

extension DetailPresenter: DetailPresentationLogic {
    
    /// 이전 화면에서 받아온 깃허브 사용자 정보를
    /// ViewModel 포맷으로 변환 후 ViewController에 전달하기
    /// - Parameter userInfo: 이전 화면에서 받아온 깃허브 사용자 정보 데이터
    func convertResponseFormat(userInfoDetails: UserInfo?) {
        guard let userInfoDetails = userInfoDetails else { return }
        
        let tableViewData = [
            ("아이디", userInfoDetails.id),
            ("이름", userInfoDetails.name),
            ("소개", userInfoDetails.bio),
            ("위치", userInfoDetails.location),
            ("팔로워", "\(userInfoDetails.followers)명"),
            ("팔로잉", "\(userInfoDetails.following)명"),
            ("공개 Repository", "\(userInfoDetails.publicRepositories)개"),
            ("공개 Gist", "\(userInfoDetails.publicGists)개"),
        ]
        
        let viewModel = DetailModel.DisplayUserInfoDetails.ViewModel(tableViewData: tableViewData)
        
        self.viewController?.displayUserDetail(viewModel: viewModel)
    }
    
}
