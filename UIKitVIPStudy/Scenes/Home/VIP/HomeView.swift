//
//  HomeView.swift
//  UIKitVIPStudy
//
//  Created by Eric on 11/30/23.
//

import UIKit

protocol HomeViewDelegate: AnyObject {
    func seeDetailsButtonTapped()
}

class HomeView: UIView {
    
    let userProfileImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage()
        iv.contentMode = .scaleToFill
        iv.layer.borderColor = UIColor.label.cgColor
        iv.layer.borderWidth = 2
        iv.layer.cornerRadius = 50
        iv.clipsToBounds = true
        return iv
    }()
    
    let userProfileName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "데이터를 받아오는 중..."
        return label
    }()
    
    lazy var seeDetailsButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .tintColor
        button.setTitle("상세 정보 보기", for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(self.buttonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: HomeViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupSubview()
        self.setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HomeView {
    
    /// 하위뷰 추가
    private func setupSubview() {
        self.addSubview(self.userProfileImage)
        self.addSubview(self.userProfileName)
        self.addSubview(self.seeDetailsButton)
    }
    
    /// 오토레이아웃 설정
    private func setupAutoLayout() {
        self.userProfileImage.translatesAutoresizingMaskIntoConstraints = false
        self.userProfileName.translatesAutoresizingMaskIntoConstraints = false
        self.seeDetailsButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.userProfileImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50),
            self.userProfileImage.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            self.userProfileImage.widthAnchor.constraint(equalToConstant: 100),
            self.userProfileImage.heightAnchor.constraint(equalToConstant: 100),
            
            self.userProfileName.topAnchor.constraint(equalTo: self.userProfileImage.bottomAnchor, constant: 10),
            self.userProfileName.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            self.userProfileName.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            self.seeDetailsButton.topAnchor.constraint(equalTo: self.userProfileName.bottomAnchor, constant: 50),
            self.seeDetailsButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            self.seeDetailsButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            self.seeDetailsButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    /// 버튼이 선택되었을 때 ViewController에서 대신 메서드를 실행합니다.
    /// - Parameter button: 클릭한 버튼
    @objc private func buttonTapped(_ button: UIButton) {
        self.delegate?.seeDetailsButtonTapped()
    }
    
    /// 뷰컨트롤러에서 받은 값으로 UI 설정
    /// - Parameters:
    ///   - image: 깃허브 프로필 이미지
    ///   - name: 깃허브 프로필 이름
    func setupView(imageURL: String, name: String) {
        // 백그라운드 쓰레드에서 작업 후 메인 쓰레드에서 UI 업데이트 진행 (load 확장 메서드)
        self.userProfileImage.load(url: imageURL)
        
        // 위에서 백그라운드 쓰레드를 사용하기 때문에 메인 쓰레드에서 작동하도록 처리해야 함
        DispatchQueue.main.async {
            self.userProfileName.text = name
        }
    }
    
}
