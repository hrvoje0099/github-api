//
//  RepoView.swift
//  ArsFuturaTask
//
//  Created by Hrvoje Vuković on 21.11.2021.
//

import UIKit

final class RepoView: UIView {
    
    // MARK: - PROPERTIES
    
    var repoTableView = UITableView()
    var userInfoHeader = UserInfoHeaderSmall()
    
    // MARK: - INIT
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupView() {
        addElementsOnView()
        setConstraintsForElements()
    }
    
    private func addElementsOnView() {
        repoTableView = UITableView(frame: frame, style: .grouped)
        repoTableView.translatesAutoresizingMaskIntoConstraints = false
        repoTableView.register(DataCell.self, forCellReuseIdentifier: DataCell.DataCellReuseIdentifier)
        repoTableView.sectionHeaderHeight = 0
        repoTableView.sectionFooterHeight = 0
        repoTableView.estimatedRowHeight = 80
        repoTableView.rowHeight = UITableView.automaticDimension
        repoTableView.backgroundColor = Constants.Colors.backgroundColor
        
        let frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 74)
        userInfoHeader.frame = frame
        
        repoTableView.tableHeaderView = userInfoHeader
        addSubview(repoTableView)
    }
    
    private func setConstraintsForElements() {
        NSLayoutConstraint.activate([
            repoTableView.leftAnchor.constraint(equalTo: leftAnchor),
            repoTableView.topAnchor.constraint(equalTo: topAnchor),
            repoTableView.rightAnchor.constraint(equalTo: rightAnchor),
            repoTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
