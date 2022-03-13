//
//  RepoViewController.swift
//  ArsFuturaTask
//
//  Created by Hrvoje Vuković on 21.11.2021.
//

import UIKit

final class RepoViewController: UIViewController {
    
    // MARK: - PROPERTIES
        
    private lazy var repoView: RepoView = {
        let repoView = RepoView()
        repoView.repoTableView.delegate = self
        repoView.repoTableView.dataSource = self
        
        let user = repoViewModel.getUserData()
        repoView.userInfoHeader.avatarImageView.loadImage(at: user.avatarUrl)
        repoView.userInfoHeader.loginNameLabel.text = user.login
        repoView.userInfoHeader.htmlUrlTextView.text = user.htmlUrl
        
        return repoView
    }()
    
    private let repoViewModel: RepoViewModelProtocol
    
    // MARK: - INIT
    
    init(viewModel: RepoViewModelProtocol) {
        self.repoViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = repoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupNavigation() {
        extendedLayoutIncludesOpaqueBars = true
        title = repoViewModel.getRepoName()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.restoreHairline()
    }
    
}

// MARK: - TABLE VIEW DATA SOURCE

extension RepoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repoViewModel.getNumberOfOptions(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DataCell.DataCellReuseIdentifier, for: indexPath) as? DataCell else { return UITableViewCell() }
        let option = repoViewModel.getOptionForSection(at: indexPath)
        let repoData = repoViewModel.getRepoData(for: option)
        cell.valueTextView.text = repoData
        cell.option = option
        return cell
    }
}

// MARK: - TABLE VIEW DELEGATE

extension RepoViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return repoViewModel.getSectionCount()
    }
}
