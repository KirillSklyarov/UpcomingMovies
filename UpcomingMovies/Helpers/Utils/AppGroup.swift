//
//  AppGroup.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/13/21.
//  Copyright © 2021 Alonso. All rights reserved.
//

enum AppGroup: String, CaseIterable {

//    case movies = "group.movies.extension"
    case movies = "group.ru.KSklyarov.UpcomingMovies"

    static var allCasesIdentifiers: [String] {
        AppGroup.allCases.map { $0.rawValue }
    }
}
