//
//  SettingsView.swift
//  MapChallenge
//
//  Created by Yasin Akbaş on 10.12.2019.
//  Copyright © 2019 Yasin Akbaş. All rights reserved.
//

import UIKit

class SettingsView: UIView {
    
    let layout = Layout()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        tableView.separatorInset = UIEdgeInsets(top: 70, left: 70, bottom: 70, right: 70)
        
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews(tableView)
        setupTableViewConstraints()
    }
    
    private func setupTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: layout.tableViewMargins.left).isActive = true
        tableView.topAnchor.constraint(equalTo: topAnchor, constant: layout.tableViewMargins.top).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: layout.tableViewMargins.right).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: layout.tableViewMargins.bottom).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    struct Layout {
        let tableViewMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
