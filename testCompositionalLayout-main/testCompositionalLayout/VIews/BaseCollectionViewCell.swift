//
//  BaseCollectionViewCell.swift
//  testCompositionalLayout
//
//  Created by Даниил Ермоленко on 04.10.2022.
//

import Foundation
import UIKit

// MARK: - SelfConfiguringCellProtocol
protocol SelfConfiguringCell {
    
    static var reuseIdentifier: String { get }
    func configure(with item: Item)
}

// MARK: - BaseCollectionViewCell
class BaseCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .gray
        imageView.tintColor = .darkGray
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let descriptionLabel: UILabel = {
        let label = EdgeInsetLabel()
        label.textColor = .black
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        label.sizeToFit()
        label.textAlignment = .left
        label.textInsets = UIEdgeInsets(top: 13, left: 15, bottom: 13, right: 15)
        label.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        label.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 18, weight: .medium))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                layer.borderWidth = 2
                layer.borderColor = UIColor.purple.cgColor
                layer.cornerRadius = 10
            } else {
                layer.borderWidth = 0
            }
        }
    }
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - setupViews
    func setupViews() {
        addSubview(imageView)
        imageView.addSubview(descriptionLabel)
    }
    // MARK: - setConstraints
    func setConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

