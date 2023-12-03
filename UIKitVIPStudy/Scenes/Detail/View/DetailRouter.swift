//
//  DetailRouter.swift
//  UIKitVIPStudy
//
//  Created by Eric on 12/1/23.
//

import Foundation

//MARK: - 속성 선언 및 초기화

/// 화면 전환을 담당하는 클래스
class DetailRouter: DetailRoutingLogic {

    /// **ViewController**
    weak var viewController: DetailViewController?
    
    init(viewController: DetailViewController) {
        self.viewController = viewController
    }
    
}
