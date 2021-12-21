//
//  UserCell.swift
//  ArsFuturaTask
//
//  Created by Hrvoje Vuković on 17.11.2021.
//

import UIKit

final class UserCell: UITableViewCell {
    
    static let UserCellReuseIdentifier = "UserCell"
    
    // MARK: - PROPERTIES
    
    let avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.image = UIImage(systemName: "questionmark.circle")
        avatarImageView.tintColor = .systemGray5
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true
        return avatarImageView
    }()
    
    let loginNameLabel: UILabel = {
        let loginNameLabel = UILabel()
        loginNameLabel.translatesAutoresizingMaskIntoConstraints = false
        loginNameLabel.font = .systemFont(ofSize: 17)
        return loginNameLabel
    }()
    
    let htmlUrlLabel: UILabel = {
        let htmlUrlLabel = UILabel()
        htmlUrlLabel.translatesAutoresizingMaskIntoConstraints = false
        htmlUrlLabel.font = .systemFont(ofSize: 15)
        htmlUrlLabel.textColor = Constants.Colors.htmlUrlColorLowerAlpha
        return htmlUrlLabel
    }()
    
    // MARK: - INIT
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = UIImage(systemName: "questionmark.circle")
        avatarImageView.cancelImageLoad()
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupView() {
        let avatarImageDimension: CGFloat = 45
        avatarImageView.layer.cornerRadius = avatarImageDimension / 2
        
        accessoryType = .disclosureIndicator
        
        addElementsOnView()
        setConstraintsForElements(avatarImageDimension)
    }
    
    private func addElementsOnView() {
        addSubview(avatarImageView)
        addSubview(loginNameLabel)
        addSubview(htmlUrlLabel)
    }
    
    private func setConstraintsForElements(_ avatarImageDimension: CGFloat) {
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            avatarImageView.widthAnchor.constraint(equalToConstant: avatarImageDimension),
            avatarImageView.heightAnchor.constraint(equalToConstant: avatarImageDimension),
            
            loginNameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: -15),
            loginNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            
            htmlUrlLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 15),
            htmlUrlLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
        ])
    }
}
