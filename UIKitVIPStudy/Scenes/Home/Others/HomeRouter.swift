//
//  HomeRouter.swift
//  UIKitVIPStudy
//
//  Created by Eric on 11/30/23.
//

import UIKit

//MARK: - 프로토콜 선언

/// Routing 로직을 수행하기 위해 준수해야 하는 프로토콜
protocol HomeSceneRoutingLogic {
    var viewController: HomeViewController? { get }
    
    func navigateToDetail(dataToPass: UserInfo, animated: Bool)
}

//MARK: - 속성 선언

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

extension HomeRouter: HomeSceneRoutingLogic {
    
    func navigateToDetail(dataToPass: UserInfo, animated: Bool) {
        let detailViewController = DetailViewController(dataToReceive: dataToPass)
        self.viewController?.navigationController?.pushViewController(detailViewController, animated: animated)
    }
    
}
