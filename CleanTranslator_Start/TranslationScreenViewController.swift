//  TranslationScreenViewController.swift
//  CleanTranslator
//
//  Created by Stanislav Anatskii on 20.02.2022.
//  
//

import UIKit

final class TranslationScreenViewController: UIViewController {

    // MARK: - Private Properties

    private let mainView: TranslationScreenView
    private let alertFactory: AlertFactory
    private let translationService: TranslationService

    // MARK: - Init

    init(
        translationService: TranslationService = ServiceLayer.shared.translationService,
        alertFactory: AlertFactory = MainAlertFactory()) {
            
        self.translationService = translationService
        self.alertFactory = alertFactory
        mainView = TranslationScreenView()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder _: NSCoder) {
        return nil
    }
    
    // MARK: - Lifecycle

    override func loadView() {
        view = mainView
        mainView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.setup(buttonTitle: "Translate, please!")
    }
    
    // MARK: - Private methods
    
    private func showTranslation(text: String) {
        mainView.showTranslation(text: text)
    }
    
    private func showError(_ error: Error) {
        let alert = alertFactory.createErrorAlert(message: error.localizedDescription)
        present(alert, animated: true, completion: nil)
    }
}

extension TranslationScreenViewController: TranslationScreenViewDelegate {
    
    func translate(text: String) {
        translationService.translate(with: TranslationRequestModel(
            text: [text],
            modelId: "en-ru")) { [weak self] result in
                
            switch result {
            case .success(let model):
                let plainText = model.translations.map { $0.translation }.joined(separator: " ")
                self?.showTranslation(text: plainText)
            case .failure(let error):
                self?.showError(error)
            }
        }
    }
}
