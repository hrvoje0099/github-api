//
//  UserInfoHeaderSmall.swift
//  ArsFuturaTask
//
//  Created by Hrvoje Vuković on 23.11.2021.
//

import UIKit

final class UserInfoHeaderSmall: UIView {
    
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
        htmlUrlTextView.isEditable = false
        htmlUrlTextView.dataDetectorTypes = .link
        htmlUrlTextView.isScrollEnabled = false
        htmlUrlTextView.textContainer.lineFragmentPadding = 0
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
        let avatarImageDimension: CGFloat = 45
        avatarImageView.layer.cornerRadius = avatarImageDimension / 2
        
        backgroundColor = .white
        
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
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            avatarImageView.widthAnchor.constraint(equalToConstant: avatarImageDimension),
            avatarImageView.heightAnchor.constraint(equalToConstant: avatarImageDimension),
            
            loginNameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: -15),
            loginNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            
            htmlUrlTextView.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 15),
            htmlUrlTextView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
        ])
    }
}
