//
//  DetailInteractor.swift
//  UIKitVIPStudy
//
//  Created by Eric on 12/1/23.
//

import Foundation

//MARK: - 프로토콜 선언

typealias DetailSceneInteractorInput = DetailSceneViewControllerOutput

protocol DetailSceneInteractorOutput: AnyObject {
//    func sendTableViewData(user: DetailModel.Response.User?)
    func convertUserInfoDetails(user: UserInfo?)
}

//MARK: - 속성 선언

final class DetailInteractor {
    
    var presenter: DetailSceneInteractorOutput?
    
//    var user: HomeModel.Response.User?
    
    /// ListInteractor 인스턴스를 생성
    /// - Parameters:
    ///   - presenter: interactor의 output
    init(presenter: DetailSceneInteractorOutput) {
        self.presenter = presenter
    }
    
}

//MARK: - 내부 메서드 구현

extension DetailInteractor {
    
}

//MARK: - ViewController -> Interactor 통신

extension DetailInteractor: DetailSceneInteractorInput {

    func doSomething() {
        
    }
    
}
