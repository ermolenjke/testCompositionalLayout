//
//  AppModel.swift
//  testCompositionalLayout
//
//  Created by Даниил Ермоленко on 03.10.2022.
//

import Foundation

// MARK: - AppModel
struct AppModel: Decodable, Hashable {
    let sections: [Section]
}

// MARK: - Section
struct Section: Decodable, Hashable {
    let header: String
    let items: [Item]
}

// MARK: - Item
struct Item: Decodable, Hashable {
    let title: String
}



