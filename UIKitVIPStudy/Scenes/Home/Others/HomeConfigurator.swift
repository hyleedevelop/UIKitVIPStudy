//
//  HomeConfigurator.swift
//  UIKitVIPStudy
//
//  Created by Eric on 11/30/23.
//

import Foundation

/// Home 화면에서 VIP 아키텍처의 각 요소를 연결하는 역할을 맡는 싱글톤 객체이다.
final class HomeConfigurator {
    
    static let shared = HomeConfigurator()
    private init() {}
    
    /// Router, ViewController, Interactor, Presenter를 서로 연결짓는다.
    /// - Parameter viewController: ViewController
    func configure(viewController: HomeViewController) {
        let router = HomeRouter(viewController: viewController)
        let presenter = HomePresenter(viewController: viewController)
        let interactor = HomeInteractor(presenter: presenter)
        
        viewController.interactor = interactor
        viewController.router = router
    }
    
}
