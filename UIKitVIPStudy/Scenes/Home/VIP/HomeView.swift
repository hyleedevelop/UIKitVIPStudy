//
//  HomeView.swift
//  UIKitVIPStudy
//
//  Created by Eric on 11/30/23.
//

import UIKit

//MARK: - 프로토콜 선언

protocol HomeViewDelegate: AnyObject {
    func searchButtonTapped(input: String)
    func seeDetailsButtonTapped()
}

//MARK: - 속성 선언 및 초기화

class HomeView: UIView {
    
    /// 아이디 텍스트필드
    let idTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Github 아이디 입력"
        tf.borderStyle = .roundedRect
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.returnKeyType = .done
        tf.clearButtonMode = .whileEditing
        return tf
    }()
    
    /// 검색 버튼
    private lazy var searchButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .tintColor
        button.setTitle("검색", for: .normal)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(self.buttonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    /// 아이디 텍스트필드와 검색 버튼을 수평으로 묶은 스택뷰
    private lazy var searchStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [self.idTextField, self.searchButton])
        sv.axis = .horizontal
        sv.alignment = .center
        sv.distribution = .fill
        sv.spacing = 10
        return sv
    }()
    
    /// 프로필 이미지
    private let userProfileImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage()
        iv.contentMode = .scaleToFill
        iv.layer.borderColor = UIColor.label.cgColor
        iv.layer.borderWidth = 2
        iv.layer.cornerRadius = 75
        iv.clipsToBounds = true
        return iv
    }()
    
    /// 프로필 이름
    private let userProfileName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "?"
        return label
    }()
    
    /// 상세 정보 보기 버튼
    private lazy var seeDetailsButton: UIButton = {
        let button = UIButton(type: .custom)
        button.isEnabled = false
        button.backgroundColor = .systemGray5
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

//MARK: - 내부 메서드

extension HomeView {
    
    /// 하위뷰 추가
    private func setupSubview() {
        self.addSubview(self.searchStackView)
        self.addSubview(self.userProfileImage)
        self.addSubview(self.userProfileName)
        self.addSubview(self.seeDetailsButton)
    }
    
    /// 오토레이아웃 설정
    private func setupAutoLayout() {
        self.searchStackView.translatesAutoresizingMaskIntoConstraints = false
        self.userProfileImage.translatesAutoresizingMaskIntoConstraints = false
        self.userProfileName.translatesAutoresizingMaskIntoConstraints = false
        self.seeDetailsButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.searchStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.searchStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            self.searchStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            self.searchButton.widthAnchor.constraint(equalToConstant: 50),
            
            self.userProfileImage.topAnchor.constraint(equalTo: self.searchStackView.bottomAnchor, constant: 50),
            self.userProfileImage.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            self.userProfileImage.widthAnchor.constraint(equalToConstant: 150),
            self.userProfileImage.heightAnchor.constraint(equalToConstant: 150),
            
            self.userProfileName.topAnchor.constraint(equalTo: self.userProfileImage.bottomAnchor, constant: 10),
            self.userProfileName.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            self.userProfileName.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            self.seeDetailsButton.topAnchor.constraint(equalTo: self.userProfileName.bottomAnchor, constant: 50),
            self.seeDetailsButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            self.seeDetailsButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            self.seeDetailsButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    /// 버튼이 선택되었을 때 ViewController에서 대신 실행할 내용
    /// - Parameter button: 클릭한 버튼
    @objc private func buttonTapped(_ button: UIButton) {
        if button == self.searchButton {
            self.delegate?.searchButtonTapped(input: self.idTextField.text ?? "")
        }
        
        if button == self.seeDetailsButton {
            self.delegate?.seeDetailsButtonTapped()
        }
    }
    
}

//MARK: - ViewController에 의해 호출되는 메서드

extension HomeView {
    
    /// 네트워킹에 성공했을 때의 UI 설정
    /// - Parameters:
    ///   - image: 깃허브 프로필 이미지
    ///   - name: 깃허브 프로필 이름
    func setupView(imageURL: String, name: String) {
        // 백그라운드 쓰레드에서 작업 후 메인 쓰레드에서 UI 업데이트 진행 (load 확장 메서드)
        self.userProfileImage.load(url: imageURL)
        
        // 위에서 백그라운드 쓰레드를 사용하기 때문에 메인 쓰레드에서 작동하도록 처리해야 함
        DispatchQueue.main.async {
            self.userProfileName.text = name
            self.seeDetailsButton.isEnabled = true
            self.seeDetailsButton.backgroundColor = .tintColor
        }
    }
    
    /// 네트워킹에 실패했을 때의 UI 설정
    func setupView() {
        DispatchQueue.main.async {
            self.userProfileImage.image = UIImage(systemName: "xmark")
            self.userProfileImage.tintColor = .red
            self.userProfileName.text = "사용자를 찾을 수 없음"
        }
    }
    
}
