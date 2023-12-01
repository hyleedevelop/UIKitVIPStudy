//
//  DetailPresenter.swift
//  UIKitVIPStudy
//
//  Created by Eric on 12/1/23.
//

import Foundation

//MARK: - 프로토콜 선언

typealias DetailScenePresenterInput = DetailSceneInteractorOutput

protocol DetailScenePresenterOutput: AnyObject {
    func displayUserDetail(user: DetailModel.DisplayUserInfoDetails.ViewModel)
}

//MARK: - 속성 선언

final class DetailPresenter {
    
    weak var viewController: DetailScenePresenterOutput?
    
    /// ListPresenter 인스턴스를 생성
    /// - Parameter viewController: presenter의 output
    init(viewController: DetailScenePresenterOutput) {
        self.viewController = viewController
    }
    
}

//MARK: - 내부 메서드 구현

extension DetailPresenter {
    
}

//MARK: - Interactor -> Presenter 통신

extension DetailPresenter: DetailScenePresenterInput {
    
    func convertUserInfoDetails(user: UserInfo?) {
        guard let user = user else { return }
        
        var cellData = [String]()
        cellData.append("아이디는 \(user.id) 입니다.")
        cellData.append("이름은 \(user.name) 입니다.")
        cellData.append("소개말은 '\(user.bio)' 입니다.")
        cellData.append("현재 위치는 \(user.location) 입니다.")
        
        let viewModel = DetailModel.DisplayUserInfoDetails.ViewModel(details: cellData)
        
        self.viewController?.displayUserDetail(user: viewModel)
    }
    
}
