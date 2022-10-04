//
//  FirstCollectionViewCell.swift
//  testCompositionalLayout
//
//  Created by Даниил Ермоленко on 03.10.2022.
//

import UIKit

class EatingPsychologyCollectionViewCell: BaseCollectionViewCell, SelfConfiguringCell {
    
    static let reuseIdentifier: String = "eatingPsychologyCell"
    
    func configure(with item: Item) {
        descriptionLabel.text = item.title
        imageView.image = UIImage(systemName: "photo")
    }
}
    
