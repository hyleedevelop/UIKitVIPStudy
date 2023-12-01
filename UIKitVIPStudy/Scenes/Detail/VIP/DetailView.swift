//
//  DetailView.swift
//  UIKitVIPStudy
//
//  Created by Eric on 11/30/23.
//

import UIKit

//MARK: - 프로토콜 선언

protocol DetailViewDelegate: AnyObject {
    func visitButtonTapped()
}

//MARK: - 속성 선언 및 초기화

class DetailView: UIView {
    
    /// 깃허브 페이지 이동 버튼
    private lazy var visitButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .systemBackground
        button.setImage(UIImage(named: "github-mark"), for: .normal)
        button.layer.cornerRadius = 50
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(self.buttonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    /// 상세정보 테이블뷰
    let tableView: UITableView = {
        let tv = UITableView()
        tv.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.identifier)
        tv.showsVerticalScrollIndicator = true
        tv.separatorStyle = .singleLine
        tv.allowsSelection = false
        return tv
    }()
    
    weak var delegate: DetailViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupSubview()
        self.setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - 내부 메서드

extension DetailView {
    
    /// 하위뷰 추가
    private func setupSubview() {
        self.addSubview(self.visitButton)
        self.addSubview(self.tableView)
    }
    
    /// 오토레이아웃 설정
    private func setupAutoLayout() {
        self.visitButton.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.visitButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 25),
            self.visitButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            self.visitButton.widthAnchor.constraint(equalToConstant: 100),
            self.visitButton.heightAnchor.constraint(equalToConstant: 100),
            
            self.tableView.topAnchor.constraint(equalTo: self.visitButton.bottomAnchor, constant: 25),
            self.tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    /// 버튼이 선택되었을 때 ViewController에서 대신 실행할 내용
    /// - Parameter button: 클릭한 버튼
    @objc private func buttonTapped(_ button: UIButton) {
        self.delegate?.visitButtonTapped()
        
    }

}
