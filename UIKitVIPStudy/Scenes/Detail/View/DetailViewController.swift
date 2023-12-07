//
//  DetailViewController.swift
//  UIKitVIPStudy
//
//  Created by Eric on 11/30/23.
//

import UIKit

//MARK: - 프로토콜 선언

/// **ViewController** -> **Interactor** 통신을 위해 준수해야 하는 프로토콜
protocol DetailBusinessLogic: AnyObject {
    func passUserInfoToPresenter(request: DetailModel.DisplayUserInfoDetails.Request)
}

/// **ViewController** -> **Router** 통신을 위해 준수해야 하는 프로토콜
protocol DetailRoutingLogic: AnyObject {
    var viewController: DetailViewController? { get }
    
    func navigateToGithub(userID: String)
}

//MARK: - 속성 선언 및 초기화

/// 사용자로부터 입력을 받고 화면 표시를 담당하는 객체
final class DetailViewController: UIViewController {
    
    /// 이전 화면에서 전달받을 데이터
    var dataToReceive: UserInfo
    
    /// **View**
    private let detailView = DetailView()
    
    /// **Model**
    private var viewModel: DetailModel.DisplayUserInfoDetails.ViewModel?
    
    /// **Router** (Configurator에 의해 초기화 됨)
    var router: DetailRoutingLogic!
    
    /// **Interactor** (Configurator에 의해 초기화 됨)
    var interactor: DetailBusinessLogic!
    
    /// ViewController의 인스턴스를 생성
    /// - Parameters:
    ///   - dataToReceive: 이전 화면으로부터 전달받을 데이터
    ///   - configurator: Configurator 싱글톤 인스턴스
    init(dataToReceive: UserInfo, configurator: DetailConfigurator = DetailConfigurator.shared) {
        self.dataToReceive = dataToReceive
        
        // 모든 속성이 초기화되어 있어야 super.init 호출 가능
        super.init(nibName: nil, bundle: nil)
        
        configurator.configure(viewController: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - 내부 메서드

extension DetailViewController {
    
    /// 뷰 불러오기
    override func loadView() {
        self.view = detailView
    }
    
    /// **View** 초기화 이후 실행할 작업
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
        self.dataReceivedFromPreviousScene()
    }
    
    /// **View** 설정
    private func setupView() {
        // View의 배경 색상 설정
        self.view.backgroundColor = .systemBackground

        // 네비게이션 바 제목 설정
        self.navigationItem.title = "상세정보"
        
        // View의 대리자 설정
        self.detailView.delegate = self
        
        // TableView의 대리자 설정
        self.detailView.tableView.delegate = self
        self.detailView.tableView.dataSource = self
    }
    
    /// 이전 화면에서 받은 데이터를 현재 화면에 표시할 수 있도록 가공하기 위해 **Presenter**에 전달
    func dataReceivedFromPreviousScene() {
        let request = DetailModel.DisplayUserInfoDetails.Request(data: self.dataToReceive)
        self.interactor.passUserInfoToPresenter(request: request)
    }
    
}

//MARK: - Presenter -> ViewController 통신

extension DetailViewController: DetailDisplayLogic {

    /// TableView에 사용자 상세 정보 표시
    func displayUserDetail(viewModel: DetailModel.DisplayUserInfoDetails.ViewModel) {
        self.viewModel = viewModel
        
        DispatchQueue.main.async {
            self.detailView.tableView.reloadData()
        }
    }
    
}

//MARK: - 테이블뷰 델리게이트 메서드

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.tableViewData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as? DetailTableViewCell else { return UITableViewCell() }
        //cell.textLabel?.text = self.viewModel?.details[indexPath.row]
        cell.setupCellUI(
            title: self.viewModel?.tableViewData[indexPath.row].0 ?? "",
            description: self.viewModel?.tableViewData[indexPath.row].1 ?? ""
        )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}

//MARK: - View 델리게이트 메서드

extension DetailViewController: DetailViewDelegate {
    
    /// 깃허브 로고 버튼이 눌러졌을 때 실행할 내용
    func visitButtonTapped() {
        self.router.navigateToGithub(userID: self.dataToReceive.id)
    }
    
}
