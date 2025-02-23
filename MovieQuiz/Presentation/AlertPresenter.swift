//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by MacBook Pro on 21.02.2025.
//

import UIKit

final class AlertPresenter {
    static func showAlert(viewController: UIViewController, quiz result: AlertModel) {
        let alert = UIAlertController(
            title: result.title,
            message: result.message,
            preferredStyle: .alert)
        
        let action = UIAlertAction(title: result.buttonText, style: .default) { _ in result.completion()}
        
        alert.addAction(action)
        
        viewController.present(alert, animated: true, completion: nil)
    }
}
