//
//  MovieDetailPosterCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 27/06/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import UIKit

protocol MovieDetailPosterCoordinatorProtocol: AnyObject { }

final class MovieDetailPosterCoordinator: BaseCoordinator, MovieDetailPosterCoordinatorProtocol {

    private let renderContent: MovieDetailPosterRenderContent?
    private weak var delegate: MovieDetailPosterViewControllerDelegate?

    init(navigationController: UINavigationController,
         renderContent: MovieDetailPosterRenderContent?,
         delegate: MovieDetailPosterViewControllerDelegate?) {
        self.renderContent = renderContent
        self.delegate = delegate
        super.init(navigationController: navigationController)
    }

    override func build() -> MovieDetailPosterViewController {
        let viewController = MovieDetailPosterViewController.instantiate()
        viewController.delegate = delegate

        var viewModel: MovieDetailPosterViewModelProtocol = DIContainer.shared.resolve(argument: renderContent)
        viewModel.view = viewController
        viewController.initialize(with: viewModel)

        return viewController
    }

}
