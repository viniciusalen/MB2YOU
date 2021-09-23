//
//  SimilarMoviesTableCellViewModel.swift
//  MB2YOU
//
//  Created by Vinicius Alencar on 9/22/21.
//

import Foundation
import UIKit

class SimilarMoviesTableCellViewModel {
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var similarMovie: MovieDetails
    
    var titleMovie: String {
        return similarMovie.originalTitle
    }
    
    var yearMovie: String {
        let year = similarMovie.date
        return getYearString(date: year)
    }
    
    var pathImageMovie: String? {
        guard let path: String = similarMovie.backdropPath else {
            return nil
        }
        return path
    }
    
    var genreMovie: String? {
        guard let genre: Int = similarMovie.genres?.first else {
            return nil
        }
        return String(genre)
    }
    
    //*************************************************
    // MARK: - Inits
    //*************************************************
    
    init(similarMovie: MovieDetails) {
        self.similarMovie = similarMovie
    }
}

//*************************************************
// MARK: - Private Methods
//*************************************************

extension SimilarMoviesTableCellViewModel {
    func getYearString(date: String) -> String {
        let start = date.index(date.startIndex, offsetBy: 0)
        let end = date.index(date.endIndex, offsetBy: -6)
        let range = start..<end
        return String(date[range])
    }
    
    func getImageByPath(path: String) -> UIImage {
        if let url = URL(string: "https://image.tmdb.org/t/p/original" + path) {
            do {
                let imageData: Data = try Data(contentsOf: url)
                return UIImage(data: imageData as Data) ?? UIImage(systemName: "film")!
            } catch {
                print(error)
            }
        }
        return UIImage(systemName: "film")!
    }
}


