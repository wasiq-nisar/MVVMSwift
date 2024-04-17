//
//  CardModels.swift
//  MVVMSwift
//
//  Created by Muhammad Wasiq  on 15/04/2024.
//

import Foundation

struct CardResponse: Codable {
    let data: [Card]
}

struct Card: Codable {
    let id: Int
    let name: String
    let type: String
    let desc: String
    let cardImages: [CardImage]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case type = "type"
        case desc = "desc"
        case cardImages = "card_images"
    }
}

struct CardImage: Codable {
    let id: Int
    let imageURL: String
    let imageURLSmall: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case imageURL = "image_url"
        case imageURLSmall = "image_url_small"
    }
}
