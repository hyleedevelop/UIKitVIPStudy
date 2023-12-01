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
    
    func navigateToDetail(animated: Bool)
}

/// 특정 ViewController로 데이터를 전달하기 위해 준수해야 하는 프로토콜
protocol HomeSceneDataPassingLogic {
    
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

//MARK: - Routing 로직 프로토콜 메서드 구현

extension HomeRouter: HomeSceneRoutingLogic {
    
    func navigateToDetail(animated: Bool) {
        let detailViewController = DetailViewController()
        self.viewController?.navigationController?.pushViewController(detailViewController, animated: animated)
    }
    
}
