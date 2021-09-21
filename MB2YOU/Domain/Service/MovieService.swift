//
//  MovieService.swift
//  MB2YOU
//
//  Created by Vinicius Alencar on 9/20/21.
//

import Foundation


protocol MovieServiceProtocol {
    
    /// Get details movie by its ID
    /// - Parameters:
    ///   - movieID: cart ID
    ///   - completion: Return the MovieDetails or an error
    func getDetails(movieId: String, completion: @escaping (Result<MovieDetails, Error>) -> Void)
}

class MovieService {
    
    //*************************************************
    // MARK: - Private Properties
    //*************************************************
    
    private let serviceManager: ServiceManager
    
    //*************************************************
    // MARK: - Init
    //*************************************************
    
    init(service: ServiceManager = ServiceManager()) {
        self.serviceManager = service
    }
}

//*************************************************
// MARK: - MovieServiceProtocol
//*************************************************

extension MovieService: MovieServiceProtocol {
    
    func getDetails(movieId: String, completion: @escaping (Result<MovieDetails, Error>) -> Void) {
        let endpoint: Endpoint.Movie = .getDetails(movieId: movieId)
        
        serviceManager.request(endpoint, model: MovieDetails.self) { result in
            completion(result)
        }
    }
}
