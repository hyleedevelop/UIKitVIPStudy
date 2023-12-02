//
//  DetailRouter.swift
//  UIKitVIPStudy
//
//  Created by Eric on 12/1/23.
//

import Foundation

//MARK: - 속성 선언

/// 화면 전환을 담당하는 객체
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

extension DetailRouter: DetailRoutingLogic {
    
}
