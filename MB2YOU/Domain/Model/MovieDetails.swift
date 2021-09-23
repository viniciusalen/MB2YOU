//
//  MovieDetails.swift
//  MB2YOU
//
//  Created by Vinicius Alencar on 9/20/21.
//

import Foundation

struct MovieDetails: Decodable {
    let backdropPath: String?
    let id: Int
    let originalTitle: String
    let popularity: Double
    let voteCount: Int
    let genres: [Int]?
    let date: String

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case originalTitle = "original_title"
        case genres = "genre_ids"
        case popularity
        case voteCount = "vote_count"
        case date = "release_date"
    }
}
