//
//  UsersView.swift
//  ArsFuturaTask
//
//  Created by Hrvoje Vuković on 17.11.2021.
//

import UIKit

final class UsersView: UIView {
    
    // MARK: - PROPERTIES
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        return searchBar
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    var usersTableView = UITableView()
    
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
        usersTableView = UITableView(frame: frame)
        usersTableView.translatesAutoresizingMaskIntoConstraints = false
        usersTableView.register(UserCell.self, forCellReuseIdentifier: UserCell.UserCellReuseIdentifier)
        
        let frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 56)
        let view = UIView(frame: frame)
        view.backgroundColor = Constants.Colors.navigationBarColor
        
        usersTableView.tableHeaderView = view
        addSubview(usersTableView)
        
        activityIndicator.center = usersTableView.center
        addSubview(activityIndicator)
    }
    
    private func setConstraintsForElements() {
        NSLayoutConstraint.activate([
            usersTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            usersTableView.topAnchor.constraint(equalTo: self.topAnchor),
            usersTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            usersTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: usersTableView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: usersTableView.centerYAnchor)
        ])
    }
}
