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

    var result: Results
    
    var titleMovie: String {
        return result.originalTitle
    }
    
    var yearMovie: String {
        let year = result.date
        return getYearString(date: year)
    }
    
    var pathImageMovie: String? {
        guard let path: String = result.backdropPath else {
            return nil
        }
        return path
    }
    
    var genreMovie: String? {
        
        let ids: [Int] = result.genreIds
        
        if ids.count > 2 {
            return getGenreMovie(id: ids[0]) + ", " + getGenreMovie(id: ids[1])
        } else {
            return getGenreMovie(id: ids[0])
        }
    }

    //*************************************************
    // MARK: - Inits
    //*************************************************
    
    init(result: Results) {
        self.result = result
    }
}

//*************************************************
// MARK: - Public Methods
//*************************************************

extension SimilarMoviesTableCellViewModel {
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

//*************************************************
// MARK: - Private Methods
//*************************************************

extension SimilarMoviesTableCellViewModel {
    
    private func getYearString(date: String) -> String {
        let start = date.index(date.startIndex, offsetBy: 0)
        let end = date.index(date.endIndex, offsetBy: -6)
        let range = start..<end
        return String(date[range])
    }
    
    private func getGenreMovie(id: Int) -> String {
        switch id {
        case 12:
            return "Adventure"
        case 28:
            return "Action"
        case 16:
            return "Animation"
        case 35:
            return "Comedy"
        case 80:
            return "Crime"
        case 99:
            return "Documentary"
        case 18:
            return "Drama"
        case 1075:
            return "Family"
        case 14:
            return "Fantasy"
        case 36:
            return "History"
        case 27:
            return "Horror"
        case 1042:
            return "Music"
        case 9648:
            return "Mystery"
        case 10749:
            return "Romance"
        case 878:
            return "Science Fiction"
        case 10770:
            return "TV Movie"
        case 53:
            return "Thriller"
        case 10752:
            return "War"
        case 37:
            return "Western"
        default:
            return ""
        }
    }
}


