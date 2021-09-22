//
//  DetailViewController.swift
//  MB2YOU
//
//  Created by Vinicius Alencar on 9/20/21.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet private weak var titleMovieLabel: UILabel!
    @IBOutlet private weak var popularityLabel: UILabel!
    @IBOutlet private weak var likesLabel: UILabel!
    @IBOutlet private weak var imageMovie: UIImageView!
    @IBOutlet private weak var similarTableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    //*************************************************
    // MARK: - Private Prorperties
    //*************************************************
    
    var viewModel: DetailsViewModel = DetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

//*************************************************
// MARK: - Private methods
//*************************************************

extension DetailsViewController {
    private func setupUI() {
        self.viewModel.getDetails { error in
            if let error: Error = error {
                self.presentAlert(title: "Erro", message: error.localizedDescription)
            }
            self.setupUIData()
            
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
        similarTableView.rowHeight = UITableView.automaticDimension
    }
}

extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let similarMoviesTableViewCell: SimilarMoviesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SimilarMoviesTableViewCell", for: indexPath) as? SimilarMoviesTableViewCell else {
            return UITableViewCell()
        }
        
//        let iMEIScanCodeCellViewModel: IMEIScanCodeCellViewModel = IMEIScanCodeCellViewModel(imeiValue: viewModel.getIMEIAtIndex(indexPath.row), canEditIMEI: !viewModel.shouldDeleteImeis)
//
//        iMEIScanCodeCell.setup(viewModel: iMEIScanCodeCellViewModel)
//
//        iMEIScanCodeCell.onFinishImeiInput = { [weak self] imei in
//            guard let self = self else { return }
//
//            self.viewModel.storeHexadecimal(imei, atIndex: indexPath.row)
//            self.enableSaveButton()
//        }
//
//        iMEIScanCodeCell.onStartScan = {
//            self.coordinatorDelegate?.openScanCode(delegate: iMEIScanCodeCell)
//        }
        
        return similarMoviesTableViewCell
    }
    
    
}

