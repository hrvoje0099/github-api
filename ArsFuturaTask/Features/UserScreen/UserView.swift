//
//  UserView.swift
//  ArsFuturaTask
//
//  Created by Hrvoje Vuković on 17.11.2021.
//

import UIKit

final class UserView: UIView {
    
    // MARK: - PROPERTIES
    
    var reposTableView = UITableView()
    var userInfoHeader = UserInfoHeaderBig()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
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
        reposTableView = UITableView(frame: frame, style: .grouped)
        reposTableView.translatesAutoresizingMaskIntoConstraints = false
        reposTableView.register(RepoCell.self, forCellReuseIdentifier: RepoCell.RepoCellReuseIdentifier)
        reposTableView.estimatedRowHeight = 80
        reposTableView.rowHeight = UITableView.automaticDimension
        
        let frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 202)
        userInfoHeader.frame = frame
        
        reposTableView.tableHeaderView = userInfoHeader
        addSubview(reposTableView)
        
        activityIndicator.center = reposTableView.center
        addSubview(activityIndicator)
    }
    
    private func setConstraintsForElements() {
        NSLayoutConstraint.activate([
            reposTableView.leftAnchor.constraint(equalTo: leftAnchor),
            reposTableView.topAnchor.constraint(equalTo: topAnchor),
            reposTableView.rightAnchor.constraint(equalTo: rightAnchor),
            reposTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: reposTableView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: reposTableView.centerYAnchor)
        ])
    }
}
