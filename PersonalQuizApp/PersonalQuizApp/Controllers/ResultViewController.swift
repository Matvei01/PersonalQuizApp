//
//  ResultViewController.swift
//  PersonalQuizApp
//
//  Created by Matvei Khlestov on 03.04.2024.
//

import UIKit

// MARK: -  ResultViewController
final class ResultViewController: UIViewController {
    
    // MARK: -  Private Properties
    private let first = 0
    private let second = 1
    
    // MARK: -  UI Elements
    private lazy var resultLabels: [UILabel] = {
        let labels = [
            createLabel(text: "Вы - 🐙!", font: .systemFont(ofSize: 50)),
            createLabel(text: "Вы осьминог!", font: .systemFont(ofSize: 17)),
        ]
        
        return labels
    }()
    
    private lazy var resultStackView: UIStackView = {
        createStackView(
            subviews: [resultLabels[first], resultLabels[second]]
        )
    }()
    
    // MARK: -  Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: -  Private Methods
private extension ResultViewController {
    func setupView() {
        view.backgroundColor = .white
        addSubviews()
        setupNavigationController()
        setConstraints()
    }
    
    func addSubviews() {
        setupSubviews(resultStackView)
    }
    
    func setupSubviews(_ subviews: UIView... ) {
        for subview in subviews {
            view.addSubview(subview)
        }
    }
    
    func setupNavigationController() {
        title = "Вопрос №"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func createLabel(text: String, font: UIFont) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        
        return label
    }
    
    func createStackView(subviews: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: subviews)
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }
}

// MARK: -  Constraints
private extension ResultViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            resultStackView.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            ),
            resultStackView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16
            ),
            resultStackView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16
            )
        ])
    }
}
