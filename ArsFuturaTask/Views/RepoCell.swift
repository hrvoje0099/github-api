//
//  RepoCell.swift
//  ArsFuturaTask
//
//  Created by Hrvoje Vuković on 21.11.2021.
//

import UIKit

final class RepoCell: UITableViewCell {
    
    static let RepoCellReuseIdentifier = "RepoCell"
    
    // MARK: - PROPERTIES
    
    let loginNameLabel: UILabel = {
        let loginNameLabel = UILabel()
        loginNameLabel.translatesAutoresizingMaskIntoConstraints = false
        loginNameLabel.font = .systemFont(ofSize: 17)
        loginNameLabel.textColor = Constants.Colors.paynesColor
        loginNameLabel.numberOfLines = 0
        return loginNameLabel
    }()
    
    let createdAtLabel: UILabel = {
        let createdAtLabel = UILabel()
        createdAtLabel.translatesAutoresizingMaskIntoConstraints = false
        createdAtLabel.font = .systemFont(ofSize: 12)
        createdAtLabel.textColor = .secondaryLabel
        return createdAtLabel
    }()
    
    let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = .systemFont(ofSize: 17)
        descriptionLabel.textColor = Constants.Colors.paynesColor
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        return descriptionLabel
    }()
    
    // MARK: - INIT
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupView() {
        accessoryType = .disclosureIndicator
        
        addElementsOnView()
        setConstraintsForElements()
    }
    
    private func addElementsOnView() {
        addSubview(loginNameLabel)
        addSubview(createdAtLabel)
        addSubview(descriptionLabel)
    }
    
    private func setConstraintsForElements() {
        NSLayoutConstraint.activate([
            loginNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            loginNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            loginNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            createdAtLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            createdAtLabel.topAnchor.constraint(equalTo: loginNameLabel.bottomAnchor, constant: 12),
            createdAtLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            descriptionLabel.topAnchor.constraint(equalTo: createdAtLabel.bottomAnchor, constant: 12),
        ])
    }
}
