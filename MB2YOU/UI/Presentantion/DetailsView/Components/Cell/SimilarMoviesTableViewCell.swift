//
//  SimilarMoviesTableViewCell.swift
//  MB2YOU
//
//  Created by Vinicius Alencar on 9/22/21.
//

import UIKit

class SimilarMoviesTableViewCell: UITableViewCell {

    //*************************************************
    // MARK: - IBOutlets
    //*************************************************
    
    @IBOutlet private weak var titleMovieLabel: UILabel!
    @IBOutlet private weak var yearMovieLabel: UILabel!
    @IBOutlet private weak var genreMovieLabel: UILabel!
    @IBOutlet private weak var imageMovie: UIImageView!
    
    //*************************************************
    // MARK: - Private Properties
    //*************************************************
    
    var viewModel: SimilarMoviesTableCellViewModel?
}

//*************************************************
// MARK: - Public Methods
//*************************************************

extension SimilarMoviesTableViewCell {
    func setup(viewModel: SimilarMoviesTableCellViewModel) {
        self.viewModel = viewModel
        setupUIData()
    }
}

//*************************************************
// MARK: - Private Methods
//*************************************************

extension SimilarMoviesTableViewCell {
    private func setupUIData() {
        
        guard let viewModel: SimilarMoviesTableCellViewModel = viewModel else {
            return
        }
        
        titleMovieLabel.text = viewModel.titleMovie
        yearMovieLabel.text = viewModel.yearMovie
        genreMovieLabel.text = viewModel.genreMovie
        
        if let path = viewModel.pathImageMovie {
            let image = viewModel.getImageByPath(path: path)
            self.imageMovie.image = image
        }
        else {
            self.imageMovie.image = UIImage(systemName: "film")!
        }
    }
}
