//
//  DetailViewController.swift
//  MB2YOU
//
//  Created by Vinicius Alencar on 9/20/21.
//

import UIKit

class DetailsViewController: UIViewController {

    //*************************************************
    // MARK: - IBOutlets
    //*************************************************
    
    @IBOutlet private weak var likeButton: UIButton!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var titleMovieLabel: UILabel!
    @IBOutlet private weak var popularityLabel: UILabel!
    @IBOutlet private weak var likesLabel: UILabel!
    @IBOutlet private weak var imageMovie: UIImageView!
    @IBOutlet private weak var similarTableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    //*************************************************
    // MARK: - Private Prorperties
    //*************************************************
    
    var tapped: Bool = false
    var viewModel: DetailsViewModel = DetailsViewModel()
    
    //*************************************************
    // MARK: - Life Cycle
    //*************************************************
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentInsetAdjustmentBehavior = .never
        setupUI()
    }
}

//*************************************************
// MARK: - Actions
//*************************************************

extension DetailsViewController {
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        if !tapped {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            tapped = true
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            tapped = false
        }
    }
}

//*************************************************
// MARK: - Private methods
//*************************************************

extension DetailsViewController {
    private func setupUI() {
        
        self.showLoadingIndicator()
        
        let dispatchGroup: DispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        self.viewModel.getDetails { error in
            dispatchGroup.leave()
            if let error: Error = error {
                self.presentAlert(title: "Movie Details Error", message: error.localizedDescription)
            }
        }
        
        self.likeButton.setTitle("", for: .normal)
        
        dispatchGroup.notify(queue: .main) {
            
            self.viewModel.getSimilarMovies { error in
                if let error: Error = error {
                    self.presentAlert(title: "Similar Movies Error", message: error.localizedDescription)
                }
                
                self.hideLoadingIndicator()
                self.setupUIData()
                self.similarTableView.layoutIfNeeded()
                self.tableViewHeightConstraint.constant = CGFloat(self.viewModel.quantitySimilarMovies * 102)
            }
        }
    }
    
    private func setupUIData() {
        
        popularityLabel.text = viewModel.popularity
        titleMovieLabel.text = viewModel.titleName
        likesLabel.text = viewModel.likes
        
        if let path = self.viewModel.backdropPath {
            let image = self.viewModel.getImageByPath(path: path)
            self.imageMovie.image = image
        }
        else {
            self.imageMovie.image = UIImage(systemName: "film")!
        }
        setupTable()
    }
    
    private func setupTable() {
        similarTableView.dataSource = self
        
        similarTableView.register(UINib(nibName: "SimilarMoviesTableViewCell", bundle: nil), forCellReuseIdentifier: "SimilarMoviesTableViewCell")
        similarTableView.isScrollEnabled = false
    }
}

//*************************************************
// MARK: - UITableViewDataSource
//*************************************************

extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.quantitySimilarMovies
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let similarMoviesTableViewCell: SimilarMoviesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SimilarMoviesTableViewCell", for: indexPath) as? SimilarMoviesTableViewCell,
              let similarMoviesTableCellViewModel: SimilarMoviesTableCellViewModel = viewModel.buildSimilarMoviesTableCellViewModel(index: indexPath)
        else {
            return UITableViewCell()
        }
        similarMoviesTableViewCell.setup(viewModel: similarMoviesTableCellViewModel)
        return similarMoviesTableViewCell
    }
}

