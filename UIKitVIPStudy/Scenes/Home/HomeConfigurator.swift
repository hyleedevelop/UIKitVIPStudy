//
//  HomeConfigurator.swift
//  UIKitVIPStudy
//
//  Created by Eric on 11/30/23.
//

import Foundation

/// VIP 아키텍처의 각 요소를 연결하는 역할을 맡는 싱글톤 객체
class HomeConfigurator {
    
    static let shared = HomeConfigurator()
    private init() {}
    
    /// **Router**, **ViewController**, **Interactor**, **Presenter**를 서로 연결
    /// - Parameter viewController: **ViewController**
    func configure(viewController: HomeViewController) {
        let router = HomeRouter(viewController: viewController)
        let presenter = HomePresenter(viewController: viewController)
        let interactor = HomeInteractor(presenter: presenter)
        
        viewController.interactor = interactor
        viewController.router = router
    }
    
}
