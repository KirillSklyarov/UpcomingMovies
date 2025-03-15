//
//  MovieDetailTitleViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 24/05/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import UIKit

final class MovieDetailTitleViewController: UIViewController, Storyboarded {

    @IBOutlet private weak var titleContentStackView: UIStackView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var genresLabel: UILabel!
    @IBOutlet private weak var movieRatingView: MovieRatingView!

    static var storyboardName: String = "MovieDetail"

    var viewModel: MovieDetailTitleViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindables()

        configureUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let targetSize = CGSize(width: view.bounds.width,
                                height: UIView.layoutFittingCompressedSize.height)
        preferredContentSize = view.systemLayoutSizeFitting(targetSize)
    }
}

// MARK: - Private methods
private extension MovieDetailTitleViewController {
    func setupUI() {
        titleLabel.font = FontHelper.headline
        titleLabel.adjustsFontForContentSizeCategory = true

        subtitleLabel.font = FontHelper.subheadLight
        subtitleLabel.adjustsFontForContentSizeCategory = true

        genresLabel.font = FontHelper.subheadLight
        genresLabel.adjustsFontForContentSizeCategory = true
    }

    func setupBindables() {
        viewModel?.showSubtitle.bindAndFire({ [weak self] subtitle in
            guard let self else { return }
            guard let subtitle else {
                subtitleLabel.isHidden = true
                return
            }
            subtitleLabel.text = subtitle
            subtitleLabel.isHidden = false
        }, on: .main)
        
        viewModel?.showGenresNames.bindAndFire({ [weak self] genresNames in
            guard let self else { return }
            guard let genresNames, !genresNames.isEmpty else {
                genresLabel.isHidden = true
                return
            }
            genresLabel.text = genresNames
            genresLabel.isHidden = false
        }, on: .main)
    }

    func configureUI() {
        titleLabel.text = viewModel?.title
        titleLabel.text = viewModel?.title
        movieRatingView.voteValue = viewModel?.voteAverage
    }
}
