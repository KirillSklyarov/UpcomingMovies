//
//  MovieDetailPosterViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 19/04/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import Foundation

protocol MovieDetailPosterViewModelProtocol {

    var view: MovieDetailPosterViewProtocol? { get set }
    var backdropURL: URL? { get }
    var posterURL: URL? { get }

    func viewLoaded()
}

final class MovieDetailPosterViewModel: MovieDetailPosterViewModelProtocol {

    let backdropURL: URL?
    let posterURL: URL?

    weak var view: MovieDetailPosterViewProtocol?

    init(_ renderContent: MovieDetailPosterRenderContent?) {
        self.backdropURL = renderContent?.backdropURL
        self.posterURL = renderContent?.posterURL
    }

    func viewLoaded() {
        view?.configureUI(backdropURL: backdropURL, posterURL: posterURL)
        view?.setupTransition()
    }

}
