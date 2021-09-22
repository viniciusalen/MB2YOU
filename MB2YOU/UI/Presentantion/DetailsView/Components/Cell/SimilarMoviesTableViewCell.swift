//
//  SimilarMoviesTableViewCell.swift
//  MB2YOU
//
//  Created by Vinicius Alencar on 9/22/21.
//

import UIKit

class SimilarMoviesTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleMovieLabel: UILabel!
    @IBOutlet private weak var yearMovieLabel: UILabel!
    @IBOutlet private weak var genreMovieLabel: UILabel!
    @IBOutlet private weak var imageMovie: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
