//
//  DetailsViewModel.swift
//  MB2YOU
//
//  Created by Vinicius Alencar on 9/21/21.
//

import Foundation

class DetailsViewModel {
    
    //*************************************************
    // MARK: - Private Properties
    //*************************************************
    
    private let movieService: MovieServiceProtocol
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    private(set) var detailsMovie: MovieDetails?
    
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
        movieService.getDetails(movieId: "453") { result in
            switch result {
            case .success(let movieDetails):
                self.detailsMovie = movieDetails
                completion(nil)
            case .failure(let error):
                return completion(error)
            }
        }
    }
}
