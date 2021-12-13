//
//  UserInfoHeaderBig.swift
//  ArsFuturaTask
//
//  Created by Hrvoje Vuković on 20.11.2021.
//

import UIKit

final class UserInfoHeaderBig: UIView {
    
    // MARK: - PROPERTIES
    
    var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.image = UIImage(systemName: "questionmark.circle")
        avatarImageView.tintColor = .systemGray5
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true
        return avatarImageView
    }()
    
    var loginNameLabel: UILabel = {
        let loginNameLabel = UILabel()
        loginNameLabel.translatesAutoresizingMaskIntoConstraints = false
        loginNameLabel.font = .systemFont(ofSize: 17)
        return loginNameLabel
    }()
    
    var htmlUrlTextView: UITextView = {
        let htmlUrlTextView = UITextView()
        htmlUrlTextView.translatesAutoresizingMaskIntoConstraints = false
        htmlUrlTextView.font = .systemFont(ofSize: 15)
        htmlUrlTextView.textColor = Constants.Colors.htmlUrlColorHighAlpha
        htmlUrlTextView.backgroundColor = Constants.Colors.backgroundColor
        htmlUrlTextView.isEditable = false
        htmlUrlTextView.dataDetectorTypes = .link
        htmlUrlTextView.isScrollEnabled = false
        return htmlUrlTextView
    }()
    
    // MARK: - INIT
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupView() {
        let avatarImageDimension: CGFloat = 72
        avatarImageView.layer.cornerRadius = avatarImageDimension / 2
        
        backgroundColor = Constants.Colors.backgroundColor
        
        addElementsOnView()
        setConstraintsForElements(avatarImageDimension)
    }
    
    private func addElementsOnView() {
        addSubview(avatarImageView)
        addSubview(loginNameLabel)
        addSubview(htmlUrlTextView)
    }
    
    private func setConstraintsForElements(_ avatarImageDimension: CGFloat) {
        NSLayoutConstraint.activate([
            avatarImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            avatarImageView.widthAnchor.constraint(equalToConstant: avatarImageDimension),
            avatarImageView.heightAnchor.constraint(equalToConstant: avatarImageDimension),
            
            loginNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginNameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            
            htmlUrlTextView.centerXAnchor.constraint(equalTo: centerXAnchor),
            htmlUrlTextView.topAnchor.constraint(equalTo: loginNameLabel.bottomAnchor, constant: 12)
        ])
    }
}
