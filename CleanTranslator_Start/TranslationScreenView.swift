//  TranslationScreenView.swift
//  CleanTranslator
//
//  Created by Stanislav Anatskii on 20.02.2022.
//  
//

import UIKit
import SnapKit

protocol TranslationScreenViewDelegate: AnyObject {
    func translate(text: String)
}

final class TranslationScreenView: UIView {
    
    // MARK: - Constants

    private enum Constants {
        static let buttonHeight: CGFloat = 54
        static let textViewHeight: CGFloat = 200
        static let cornerRadius: CGFloat = 8
        static let font: UIFont = .systemFont(ofSize: 17)
    }
    
    // MARK: - UI
    
    private lazy var originalTextView: UITextView = {
        let textView = UITextView()
        textView.font = Constants.font
        textView.layer.borderColor = UIColor.red.cgColor
        textView.layer.borderWidth = 1
        return textView
    }()
    
    private lazy var translatedLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.font
        return label
    }()
    
    private lazy var translateButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(actionTranslate), for: .touchUpInside)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = Constants.cornerRadius
        button.titleLabel?.textColor = .white
        return button
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [originalTextView, translatedLabel, UIView(), translateButton])
        stackView.axis = .vertical
        return stackView
    }()

    // MARK: - Public Properties

    weak var delegate: TranslationScreenViewDelegate?

    // MARK: - Init

    init() {
        super.init(frame: CGRect.zero)
        setup()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods
    
    func showTranslation(text: String) {
        translatedLabel.text = text
        translatedLabel.font = .systemFont(ofSize: 17, weight: .semibold)
    }
    
    func setup(buttonTitle: String) {
        translateButton.setTitle(buttonTitle, for: .normal)
    }

    // MARK: - Private Methods

    private func setup() {
        backgroundColor = .white
        addSubview(mainStackView)
        
        mainStackView.snp.makeConstraints { make in
            make.edges.equalTo(snp_margins)
        }
        
        translateButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.buttonHeight)
        }
        
        originalTextView.snp.makeConstraints { make in
            make.height.equalTo(Constants.textViewHeight)
        }
        
        translatedLabel.snp.makeConstraints { make in
            make.height.equalTo(Constants.textViewHeight)
        }
    }
    
    // MARK: - Actions
    
    @objc private func actionTranslate() {
        guard let text = originalTextView.text, !text.isEmpty else { return }
        
        delegate?.translate(text: text)
    }
}
