//
//  ListViewController.swift
//  UIKitVIPStudy
//
//  Created by Eric on 11/30/23.
//

import UIKit

//MARK: - 프로토콜 선언

/// Presenter -> Viewcontroller 통신을 위해 준수해야 하는 프로토콜
typealias HomeSceneViewControllerInput = HomeScenePresenterOutput

/// Viewcontroller -> Interactor 통신을 위해 준수해야 하는 프로토콜
protocol HomeSceneViewControllerOutput: AnyObject {
    var userInfo: HomeModel.FetchUserInfo.Response? { get }
    
    func fetchUserInfo(request: HomeModel.FetchUserInfo.Request)
}

//MARK: - 속성 선언 및 초기화

final class HomeViewController: UIViewController {
    
    // UI
    private let homeView = HomeView()
    
    // ViewModel
    private var user: HomeModel.FetchUserInfo.ViewModel?
    
    // Components (Configurator에 의해 초기화 됨)
    var router: HomeSceneRoutingLogic!
    var interactor: HomeSceneViewControllerOutput!
    
    
    /// ViewController의 인스턴스를 생성
    /// - Parameter configurator: Configurator 싱글톤 객체
    init(configurator: HomeConfigurator = HomeConfigurator.shared) {
        super.init(nibName: nil, bundle: nil)
        
        configurator.configure(viewController: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - 내부 메서드 구현

extension HomeViewController {
    
    override func loadView() {
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
        
        let request = HomeModel.FetchUserInfo.Request(id: "hyleedevelop")
        self.interactor.fetchUserInfo(request: request)
    }
    
    /// 뷰 설정
    private func setupView() {
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = "Github 프로필"
        self.homeView.delegate = self
    }
    
}

//MARK: - Presenter -> ViewController 통신

extension HomeViewController: HomeSceneViewControllerInput {

    /// Get ViewModel data and display them on the TableView.
    func displayUserProfile(user: HomeModel.FetchUserInfo.ViewModel) {
        self.homeView.setupView(imageURL: user.imageURL, name: user.id)
    }
    
}

//MARK: - View 델리게이트 메서드 구현

extension HomeViewController: HomeViewDelegate {
    
    /// 상세 정보 보기 버튼이 눌러졌을 때 실행할 내용
    func seeDetailsButtonTapped() {
        self.router?.navigateToDetail(animated: true)
    }
    
}

