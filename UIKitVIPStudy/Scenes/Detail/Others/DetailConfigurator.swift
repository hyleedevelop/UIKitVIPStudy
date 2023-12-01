//
//  DetailConfigurator.swift
//  UIKitVIPStudy
//
//  Created by Eric on 11/30/23.
//

import Foundation

/// VIP 아키텍처의 각 요소를 연결하는 역할을 맡는 싱글톤 객체
final class DetailConfigurator {
    
    static let shared = DetailConfigurator()
    private init() {}
    
    /// Router, ViewController, Interactor, Presenter를 서로 연결
    /// - Parameter viewController: ViewController
    func configure(viewController: DetailViewController) {
        let router = DetailRouter(viewController: viewController)
        let presenter = DetailPresenter(viewController: viewController)
        let interactor = DetailInteractor(presenter: presenter)
        
        viewController.interactor = interactor
        viewController.router = router
    }
    
}
