//
//  SimilarMovies.swift
//  MB2YOU
//
//  Created by Vinicius Alencar on 9/22/21.
//

import Foundation

struct SimilarMovies: Decodable {
    let similarMovies: [Results]
    
    enum CodingKeys: String, CodingKey {
        case similarMovies = "results"
    }
}


