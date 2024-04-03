//
//  StartViewController.swift
//  PersonalQuizApp
//
//  Created by Matvei Khlestov on 02.04.2024.
//

import UIKit

// MARK: -  StartViewController
final class StartViewController: UIViewController {
    
    // MARK: -  Private Properties
    private let first = 0
    private let second = 1
    private let third = 2
    private let fourth = 3
    
    // MARK: -  UI Elements
    private lazy var animalLabels: [UILabel] = {
        let labels = [
            createLabel(text: "🐶", autoresizing: false),
            createLabel(text: "🐱", autoresizing: false),
            createLabel(text: "🐰", autoresizing: false),
            createLabel(text: "🐢", autoresizing: false)
        ]
        
        return labels
    }()
    
    private lazy var questionLabel: UILabel = {
        createLabel(text: "Какое вы животное?")
    }()
    
    private lazy var startPollButton: UIButton = {
        createButton()
    }()
    
    private lazy var startStackView: UIStackView = {
        createStackView(subviews: [questionLabel, startPollButton])
    }()
    
    // MARK: -  Action
    private lazy var buttonAction = UIAction { [ unowned self ] _ in
        let questionVC = UINavigationController(rootViewController: QuestionViewController())
        questionVC.modalPresentationStyle = .fullScreen
        present(questionVC, animated: true)
    }
    
    // MARK: -  Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: -  Private Methods
private extension StartViewController {
    func setupView() {
        view.backgroundColor = .white
        addSubviews()
        setConstraints()
    }
    
    func addSubviews() {
        setupSubviews(
            animalLabels[first],
            animalLabels[second],
            animalLabels[third],
            animalLabels[fourth],
            startStackView
        )
    }
    
    func setupSubviews(_ subviews: UIView... ) {
        for subview in subviews {
            view.addSubview(subview)
        }
    }
    
    func createLabel(text: String, autoresizing: Bool? = nil ) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = autoresizing ?? true
        
        return label
    }
    
    func createButton() -> UIButton {
        let button = UIButton(type: .system, primaryAction: buttonAction)
        button.setTitle("Начать опрос", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        
        return button
    }
    
    func createStackView(subviews: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: subviews)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }
}

// MARK: -  Constraints
private extension StartViewController {
    func setConstraints() {
        setConstraintsForAnimalLabels()
        setConstraintsForStartStackView()
    }
    //Нужно оптимизировать
    func setConstraintsForAnimalLabels() {
        NSLayoutConstraint.activate([
            animalLabels[first].topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20
            ),
            animalLabels[first].leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20
            )
        ])
        
        NSLayoutConstraint.activate([
            animalLabels[second].topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20
            ),
            animalLabels[second].trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20
            )
        ])
        
        NSLayoutConstraint.activate([
            animalLabels[third].bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20
            ),
            animalLabels[third].leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20
            )
        ])
        
        NSLayoutConstraint.activate([
            animalLabels[fourth].bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20
            ),
            animalLabels[fourth].trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20
            )
        ])
    }
    
    func setConstraintsForStartStackView() {
        NSLayoutConstraint.activate([
            startStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

