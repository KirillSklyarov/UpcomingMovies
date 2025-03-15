//
//  UpcomingMoviesLayoutProvider.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/04/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import UIKit

struct UpcomingMoviesLayoutProvider: UpcomingMoviesLayoutProviderProtocol {

    private let previewCellHeight: CGFloat = 150
    private let detailCellHeight: CGFloat = 200
    private let detailCellOffset: CGFloat = 32
    private let previewLayoutMinColumns: Int = 3

    func collectionViewLayout(for presentationMode: UpcomingMoviesPresentationMode, and collectionViewWidth: CGFloat) -> UICollectionViewLayout {
        switch presentationMode {
        case .detail:
            let detailLayoutWidth = collectionViewWidth - detailCellOffset
            return VerticalFlowLayout(preferredWidth: detailLayoutWidth, preferredHeight: detailCellHeight)
        case .preview:
            let previewLayoutWidth = previewCellHeight / CGFloat(UIConstants.posterAspectRatio)
            return VerticalFlowLayout(preferredWidth: previewLayoutWidth,
                                      preferredHeight: previewCellHeight,
                                      minColumns: previewLayoutMinColumns)
        }
    }
}
