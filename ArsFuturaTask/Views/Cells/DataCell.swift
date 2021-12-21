//
//  DataCell.swift
//  ArsFuturaTask
//
//  Created by Hrvoje Vuković on 23.11.2021.
//

import UIKit

final class DataCell: UITableViewCell {
    
    static let DataCellReuseIdentifier = "DataCell"
    
    // MARK: - PROPERTIES
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .systemFont(ofSize: 17)
        nameLabel.textColor = .secondaryLabel
        nameLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 1000) , for: .horizontal)
        nameLabel.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .horizontal)
        return nameLabel
    }()
    
    var valueTextView: UITextView = {
        let valueTextView = UITextView()
        valueTextView.translatesAutoresizingMaskIntoConstraints = false
        valueTextView.font = .systemFont(ofSize: 17)
        valueTextView.textColor = Constants.Colors.paynesColor
        valueTextView.textContainer.lineFragmentPadding = 0
        valueTextView.isEditable = false
        valueTextView.isScrollEnabled = false
        valueTextView.textContainer.lineFragmentPadding = 0
        return valueTextView
    }()
    
    var option: Options? {
        didSet {
            guard let option = option else { return }
            
            nameLabel.isHidden = !option.containsLabel
            nameLabel.text = option.description
            
            if option.isDataDetectorType { valueTextView.dataDetectorTypes = .link }
        }
    }
    
    // MARK: - INIT
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not benn implemnted")
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupView() {
        selectionStyle = .none
        
        addElementsOnView()
        setConstraintsForElements()
    }
    
    
    private func addElementsOnView() {
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(valueTextView)
        addSubview(stackView)
    }
    
    private func setConstraintsForElements() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
