//
//  QuotesModel.swift
//  Quote
//
//  Created by Дарья Петренко on 29.04.2023.
//

import Foundation

struct QuoteModel: Codable, Identifiable, Equatable {
    let id = UUID()
    let author: String
    let content: String
    let tags: [String]
    var isFavorite = false
    
    enum CodingKeys: String, CodingKey {
        case author, content, tags
    }
}
