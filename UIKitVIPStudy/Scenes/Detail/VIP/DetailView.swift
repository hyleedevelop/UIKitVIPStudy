//
//  DetailView.swift
//  UIKitVIPStudy
//
//  Created by Eric on 11/30/23.
//

import UIKit

class DetailView: UIView {
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tv.showsVerticalScrollIndicator = true
        tv.separatorStyle = .singleLine
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupSubview()
        self.setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DetailView {
    
    /// 하위뷰 추가
    private func setupSubview() {
        self.addSubview(self.tableView)
    }
    
    /// 오토레이아웃 설정
    private func setupAutoLayout() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
        ])
    }

}
