//
//  MovieDetailPosterViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 18/04/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import UIKit

protocol MovieDetailPosterViewControllerDelegate: UIViewController {
    func movieDetailPosterViewController(_ movieDetailPosterViewController: MovieDetailPosterViewController, transitionContainerView: UIView)
}

protocol MovieDetailPosterViewProtocol: AnyObject {
    func configureUI(backdropURL: URL?, posterURL: URL?)
    func setupTransition()
    func initialize(with viewModel: MovieDetailPosterViewModelProtocol)
}

final class MovieDetailPosterViewController: UIViewController, Storyboarded {

    @IBOutlet private weak var backdropImageView: UIImageView!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private(set) weak var transitionContainerView: UIView!

    static var storyboardName: String = "MovieDetail"

    var viewModel: MovieDetailPosterViewModelProtocol?
    weak var delegate: MovieDetailPosterViewControllerDelegate?

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewLoaded()
    }
}

// MARK: - Public methods
extension MovieDetailPosterViewController: MovieDetailPosterViewProtocol {
    func configureUI(backdropURL: URL?, posterURL: URL?) {
        backdropImageView.setImage(with: backdropURL)
        posterImageView.setImage(with: posterURL)
    }

    func setupTransition() {
        transitionContainerView.setShadowBorder()
        delegate?.movieDetailPosterViewController(self, transitionContainerView: transitionContainerView)
    }

    func initialize(with viewModel: MovieDetailPosterViewModelProtocol) {
        self.viewModel = viewModel
    }
}
