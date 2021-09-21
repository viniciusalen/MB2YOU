//
//  MovieDetails.swift
//  MB2YOU
//
//  Created by Vinicius Alencar on 9/20/21.
//

import Foundation

struct MovieDetails: Codable {
    let backdropPath: String?
    let id: Int
    let originalTitle: String
    let popularity: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case originalTitle = "original_title"
        case popularity
        case voteCount = "vote_count"
    }
}
