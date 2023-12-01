//
//  ListViewController.swift
//  UIKitVIPStudy
//
//  Created by Eric on 11/30/23.
//

import UIKit

//MARK: - 프로토콜 선언

/// **Presenter** -> **ViewController** 통신을 위해 준수해야 하는 프로토콜
typealias HomeSceneViewControllerInput = HomeScenePresenterOutput

/// **ViewController** -> **Interactor** 통신을 위해 준수해야 하는 프로토콜
protocol HomeSceneViewControllerOutput: AnyObject {
    var response: HomeModel.FetchUserInfo.Response? { get }
    
    func fetchUserInfo(request: HomeModel.FetchUserInfo.Request)
}

//MARK: - 속성 선언 및 초기화

final class HomeViewController: UIViewController {
    
    // 다음 화면으로 전달할 데이터
    var dataToPass: UserInfo!
    
    // View
    private let homeView = HomeView()
    
    // Model
    private var viewModel: HomeModel.FetchUserInfo.ViewModel?
    
    // Router (Configurator에 의해 초기화 됨)
    var router: HomeSceneRoutingLogic!
    
    // Interactor (Configurator에 의해 초기화 됨)
    var interactor: HomeSceneViewControllerOutput!
    
    /// ViewController의 인스턴스를 생성
    /// - Parameter configurator: Configurator 싱글톤 인스턴스
    init(configurator: HomeConfigurator = HomeConfigurator.shared) {
        super.init(nibName: nil, bundle: nil)
        
        configurator.configure(viewController: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - 내부 메서드

extension HomeViewController {
    
    /// View 불러오기
    override func loadView() {
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
    }

    /// TextField 영역 이외의 화면을 터치하면 키보드 편집 끝내기(내리기)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.homeView.idTextField.endEditing(true)
    }
    
    /// View 설정
    private func setupView() {
        // View의 배경 색상 설정
        self.view.backgroundColor = .systemBackground
        
        // 네비게이션 바 제목 설정
        self.navigationItem.title = "Github 사용자"
        
        // View의 대리자 설정
        self.homeView.delegate = self
    }
    
}

//MARK: - Presenter -> ViewController 통신

extension HomeViewController: HomeSceneViewControllerInput {

    /// 네트워킹에 성공했을 때의 화면에 사용자 프로필 표시
    func displayUserProfile(viewModel: HomeModel.FetchUserInfo.ViewModel) {
        self.homeView.setupView(imageURL: viewModel.imageURL, name: viewModel.id)
    }
    
    /// 네트워킹에 실패했을 때의 사용자 프로필 표시
    func displayFailStatus() {
        self.homeView.setupView()
    }
    
    /// 다음 화면으로 전달할 데이터 준비
    /// - Parameter dataToPass: 다음 화면으로 전달할 데이터
    func prepareDataToPass(dataToPass: UserInfo) {
        self.dataToPass = dataToPass
    }
    
}

//MARK: - View 델리게이트 메서드

extension HomeViewController: HomeViewDelegate {
    
    /// 검색 버튼이 눌러졌을 때 실행할 내용
    func searchButtonTapped(input: String) {
        let request = HomeModel.FetchUserInfo.Request(id: input)
        self.interactor.fetchUserInfo(request: request)
        
        self.homeView.idTextField.text = ""
    }
    
    /// 상세 정보 보기 버튼이 눌러졌을 때 실행할 내용
    func seeDetailsButtonTapped() {
        self.router?.navigateToDetail(dataToPass: self.dataToPass, animated: true)
    }
    
}
