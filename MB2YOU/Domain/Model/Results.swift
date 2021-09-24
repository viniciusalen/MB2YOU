//
//  Results.swift
//  MB2YOU
//
//  Created by Vinicius Alencar on 9/24/21.
//

import Foundation

struct Results: Decodable {
    let adult: Bool
    let backdropPath: String?
    let id: Int
    let originalTitle: String
    let date: String
    let genreIds: [Int]

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id
        case originalTitle = "original_title"
        case date = "release_date"
        case genreIds = "genre_ids"
    }
}
