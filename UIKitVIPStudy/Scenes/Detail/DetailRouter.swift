//
//  DetailRouter.swift
//  UIKitVIPStudy
//
//  Created by Eric on 12/1/23.
//

import UIKit

//MARK: - 속성 선언 및 초기화

/// 화면 전환을 담당하는 클래스
class DetailRouter {

    /// **ViewController**
    weak var viewController: DetailViewController?
    
    init(viewController: DetailViewController) {
        self.viewController = viewController
    }
    
}

//MARK: - Routing 로직 구현

extension DetailRouter: DetailRoutingLogic {
    
    func navigateToGithub(userID: String) {
        if let url = URL(string: "https://github.com/\(userID)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:])
            }
        }
    }
    
}
