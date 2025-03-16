//
//  UIImageView+Kingfisher.swift
//  UpcomingMovies
//
//  Created by Alonso on 10/13/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {

    func setImage(with url: URL?) {
        kf.indicatorType = .activity
        let processor = RoundCornerImageProcessor(cornerRadius: 10)
        kf.setImage(with: url,
                    placeholder: UIImage(named: "vertical-movie-placeholder"),
                    options: [.processor(processor)])
    }

    func cancelImageDownload() {
        kf.cancelDownloadTask()
    }
}
