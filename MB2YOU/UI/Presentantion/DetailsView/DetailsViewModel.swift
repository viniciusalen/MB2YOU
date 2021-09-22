//
//  DetailsViewModel.swift
//  MB2YOU
//
//  Created by Vinicius Alencar on 9/21/21.
//

import Foundation
import UIKit

class DetailsViewModel {
    
    //*************************************************
    // MARK: - Private Properties
    //*************************************************
    
    private let movieService: MovieServiceProtocol
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    private(set) var detailsMovie: MovieDetails?
    
    
    var backdropPath: String? {
        guard let path: String = detailsMovie?.backdropPath else {
            return nil
        }
        return path
    }
    
    var titleName: String? {
        guard let name: String = detailsMovie?.originalTitle else {
            return nil
        }
        return name
    }
    
    var likes: String? {
        guard let likesNumber: Int = detailsMovie?.voteCount else {
            return nil
        }
        if likesNumber > 1 {
            return String(likesNumber) + " likes"
        } else {
            return String(likesNumber) + " like"
        }
    }
    
    var popularity: String? {
        guard let popularityNumber: Double = detailsMovie?.popularity else {
            return nil
        }
        
        if popularityNumber == 1 {
            return String(popularityNumber) + " view"
        } else {
            return String(popularityNumber) + " views"
        }
    }
    
    
    //*************************************************
    // MARK: - Inits
    //*************************************************
    
    init(movieService: MovieService = MovieService()) {
        self.movieService = movieService
    }
}

//*************************************************
// MARK: - Public methods
//*************************************************

extension DetailsViewModel {
    func getDetails(completion: @escaping(Error?) -> Void) {
        movieService.getDetails(movieId: "451") { result in
            switch result {
            case .success(let movieDetails):
                self.detailsMovie = movieDetails
                completion(nil)
            case .failure(let error):
                return completion(error)
            }
        }
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
