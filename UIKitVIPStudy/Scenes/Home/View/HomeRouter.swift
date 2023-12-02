//
//  HomeRouter.swift
//  UIKitVIPStudy
//
//  Created by Eric on 11/30/23.
//

import UIKit

//MARK: - 속성 선언

/// 화면 전환을 담당하는 객체
final class HomeRouter {
    
    weak var viewController: HomeViewController?
    
    init(viewController: HomeViewController) {
        self.viewController = viewController
    }
}

//MARK: - 내부 메서드 구현

extension HomeRouter {
    
}

//MARK: - Routing 로직 구현

extension HomeRouter: HomeRoutingLogic {
    
    func navigateToDetail(dataToPass: UserInfo, animated: Bool) {
        let detailViewController = DetailViewController(dataToReceive: dataToPass)
        self.viewController?.navigationController?.pushViewController(detailViewController, animated: animated)
    }
    
}
