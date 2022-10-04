//
//  22.swift
//  testCompositionalLayout
//
//  Created by Даниил Ермоленко on 03.10.2022.
//

import UIKit

class ExplainedCollectionViewCell: BaseCollectionViewCell, SelfConfiguringCell {
    
    static let reuseIdentifier: String = "explainedCell"
    
    func configure(with item: Item) {
        descriptionLabel.text = item.title
        imageView.image = UIImage(systemName: "photo")
    }
}
