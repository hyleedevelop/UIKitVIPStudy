//
//  DetailInteractor.swift
//  UIKitVIPStudy
//
//  Created by Eric on 12/1/23.
//

import Foundation

//MARK: - 프로토콜 선언

/// **Viewcontroller -> **Interactor** 통신을 위해 준수해야 하는 프로토콜
typealias DetailInteractorInput = DetailViewControllerOutput

/// **Interactor** -> **Presenter** 통신을 위해 준수해야 하는 프로토콜
protocol DetailInteractorOutput: AnyObject {
    func convertResponseFormat(userInfoDetails: UserInfo?)
}

//MARK: - 속성 선언 및 초기화

/// 화면의 비즈니스 로직을 담당하는 객체
final class DetailInteractor {
    
    var presenter: DetailInteractorOutput?
    
    /// Interactor 인스턴스를 생성
    /// - Parameters:
    ///   - presenter: interactor의 output
    init(presenter: DetailInteractorOutput) {
        self.presenter = presenter
    }
    
}

//MARK: - ViewController -> Interactor 통신

extension DetailInteractor: DetailInteractorInput {

    /// Presenter에게 사용자 정보 데이터 전달
    func passUserInfoToPresenter(request: DetailModel.DisplayUserInfoDetails.Request) {
        let userInfoDetails = request.data
        self.presenter?.convertResponseFormat(userInfoDetails: userInfoDetails)
    }
    
}
