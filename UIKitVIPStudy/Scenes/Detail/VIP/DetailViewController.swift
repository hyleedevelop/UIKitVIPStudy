//
//  DetailViewController.swift
//  UIKitVIPStudy
//
//  Created by Eric on 11/30/23.
//

import UIKit

//MARK: - 프로토콜 선언

typealias DetailSceneViewControllerInput = DetailScenePresenterOutput

protocol DetailSceneViewControllerOutput: AnyObject {
    //var user: DetailModel.UserInfo.Response? { get }
    
    func doSomething()
}

//MARK: - 속성 선언 및 초기화

final class DetailViewController: UIViewController {
    
    // UI
    private let detailView = DetailView()
    
    // ViewModel
    private var userInfoDetails: DetailModel.DisplayUserInfoDetails.ViewModel?
    
    // Modules (Configurator에 의해 초기화 됨)
    var router: DetailSceneRoutingLogic!
    var interactor: DetailSceneViewControllerOutput!
    
    // Initializer
    init(configurator: DetailConfigurator = DetailConfigurator.shared) {
        super.init(nibName: nil, bundle: nil)
        
        configurator.configure(viewController: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DetailViewController {
    
    override func loadView() {
        self.view = detailView
        self.view.backgroundColor = .systemBackground
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = "홍길동"
    }
    
    /// Set up navigation bar.
    private func setupNavigationBar() {
        self.navigationItem.title = "User List"
    }
    
    /// Set up tableview.
    private func setupTableView() {
        self.detailView.tableView.delegate = self
        self.detailView.tableView.dataSource = self
    }
    
}

//MARK: - Presenter -> ViewController 통신

extension DetailViewController: DetailSceneViewControllerInput {

    /// Get ViewModel data and display them on the TableView.
    func displayUserDetail(user: DetailModel.DisplayUserInfoDetails.ViewModel) {
        self.userInfoDetails = user
        
        DispatchQueue.main.async {
            self.detailView.tableView.reloadData()
        }
    }
    
}

//MARK: - 테이블뷰 델리게이트 메서드 구현

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userInfoDetails?.details.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.userInfoDetails?.details[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
