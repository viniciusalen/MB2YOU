//
//  DetailViewController.swift
//  MB2YOU
//
//  Created by Vinicius Alencar on 9/20/21.
//

import UIKit

class DetailsViewController: UIViewController {

    //*************************************************
    // MARK: - Private Prorperties
    //*************************************************
    
    //*************************************************
    // MARK: - Inits
    //*************************************************
    private(set) var detailsMovie: MovieDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDetails { error in
            if let error: Error = error {
                self.presentAlert(title: "Erro", message: error.localizedDescription)
            }
        }
    }
    
    func getDetails(completion: @escaping(Error?) -> Void) {
        MovieService().getDetails(movieId: "453") { result in
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

