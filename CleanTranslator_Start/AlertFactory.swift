//
//  AlertFactory.swift
//  CleanTranslator
//
//  Created by Stanislav Anatskii on 04.03.2022.
//

import UIKit

protocol AlertFactory {
    func createErrorAlert(message: String?) -> UIViewController
}

final class MainAlertFactory: AlertFactory {
    
    func createErrorAlert(message: String?) -> UIViewController {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        return alert
    }
}
