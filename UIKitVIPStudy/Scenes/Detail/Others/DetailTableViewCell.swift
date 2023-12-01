//
//  DetailTableViewCell.swift
//  UIKitVIPStudy
//
//  Created by Eric on 12/1/23.
//

import UIKit

//MARK: - 속성 선언 및 초기화

class DetailTableViewCell: UITableViewCell {

    /// 테이블뷰 셀 ID
    static let identifier = "DetailTableViewCell"
    
    /// 항목명
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    /// 내용
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    /// 항목명과 내용을 수평으로 묶은 스택뷰
    private lazy var accountStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [self.titleLabel, self.descriptionLabel])
        sv.axis = .horizontal
        sv.alignment = .center
        sv.distribution = .equalSpacing
        sv.spacing = 20
        return sv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)

        self.addSubview()
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK: - 내부 메서드

extension DetailTableViewCell {
    
    /// 하위뷰 추가
    private func addSubview() {
        self.contentView.addSubview(self.accountStackView)
    }
    
    /// 오토레이아웃 설정
    private func setupLayout() {
        self.accountStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.accountStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.accountStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            self.accountStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.accountStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            //self.accountStackView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
}

//MARK: - ViewController에 의해 호출되는 메서드

extension DetailTableViewCell {
    
    /// 레이블 내용을 ViewController에서 전달받아 설정
    func setupCellUI(title: String, description: String) {
        self.titleLabel.text = title
        self.descriptionLabel.text = description
    }
    
}
