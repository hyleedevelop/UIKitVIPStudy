//
//  DetailRouter.swift
//  UIKitVIPStudy
//
//  Created by Eric on 12/1/23.
//

import Foundation

//MARK: - 프로토콜 선언

protocol DetailSceneRoutingLogic {
    var viewController: DetailViewController? { get }
    
    //func navigateToDetail(animated: Bool)
}

//MARK: - 속성 선언

final class DetailRouter {
    
    weak var viewController: DetailViewController?
    
    init(viewController: DetailViewController) {
        self.viewController = viewController
    }
}

//MARK: - 내부 메서드 구현

extension DetailRouter {
    
}

//MARK: - Routing 로직 프로토콜 메서드 구현

extension DetailRouter: DetailSceneRoutingLogic {
    
    //func navigateToDetail(animated: Bool) {
    //
    //}
    
}
