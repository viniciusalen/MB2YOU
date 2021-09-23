//
//  Endpoint+Movie.swift
//  MB2YOU
//
//  Created by Vinicius Alencar on 9/20/21.
//

import Foundation

extension Endpoint {
    enum Movie: RequestableProtocol {
        case getDetails(movieId: String)
        case getSimilarMovies(movieId: String)
        
        
        var url: URL {
            switch self {
            case .getDetails(let movieId):
                return URL(string: CoreSetting.apiTMDB + "/3/movie/\(movieId)?api_key=\(CoreSetting.apiKey)")!
            case .getSimilarMovies(let movieId):
                return URL(string: CoreSetting.apiTMDB + "/3/movie/\(movieId)/similar?api_key=\(CoreSetting.apiKey)")!
            }
        }
        
        var method: NetworkMethod {
            switch self {
            case .getDetails, .getSimilarMovies:
                return .get
            }
        }
        
        var titleError: String {
            switch self {
            case .getDetails:
                return "Get details"
            case .getSimilarMovies:
                return "Get Similar Movies"
            }
        }
    }
}
