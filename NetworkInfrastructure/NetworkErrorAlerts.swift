//
//  NetworkErrorAlerts.swift
//  UpcomingMovies
//
//  Created by Kirill Sklyarov on 16.03.2025.
//  Copyright © 2025 Alonso. All rights reserved.
//

import UIKit

public final class AppAlert {
    public static func create(_ errorType: APIError, completion: (() -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: "Ошибка загрузки данных", message: "", preferredStyle: .alert)
        alert.message = getErrorMessage(for: errorType)

        alert.addAction(UIAlertAction(title: "Повторить", style: .default) { _ in
            completion?()
        })

        alert.addAction(UIAlertAction(title: "OK", style: .default))

        return alert
    }

    private static func getErrorMessage(for errorType: APIError) -> String {
        return switch errorType {
        case .notAuthenticated:
            "Ошибка входа в систему.\nПроверьте логин и пароль."
        case .notFound:
            "Информация не найдена"
        case .networkProblem:
            "Проблема с сетевым подключением"
        case .badRequest:
            "Некорректный запрос к серверу"
        case .requestFailed:
            "Не удалось выполнить запрос"
        case .invalidData:
            "Получены некорректные данные"
        case .unknown(_):
            "Произошла непредвиденная ошибка"
        case .invalidResponse:
            "Получен некорректный ответ от сервера"
        case .decodingFailed:
            "Не удалось обработать полученные данные"
        case .forbidden:
            "У вас нет прав для выполнения этого действия"
        case .serverError:
            "Проблема на стороне сервера, попробуйте позже"
        case .serviceUnavailable:
            "Сервис временно недоступен, попробуйте позже"
        case .noInternetConnection:
            "Отсутствует подключение к интернету"
        case .timeout:
            "Превышено время ожидания ответа от сервера"
        case .cancelled:
            "Запрос был отменен"
        }
    }
}
