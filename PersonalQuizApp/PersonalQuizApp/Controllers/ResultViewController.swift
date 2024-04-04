//
//  ResultViewController.swift
//  PersonalQuizApp
//
//  Created by Matvei Khlestov on 03.04.2024.
//

import UIKit

// MARK: -  ResultViewController
final class ResultViewController: UIViewController {
    
    // MARK: -  Public Properties
    var answers: [Answer]!
    
    // MARK: -  Private Properties
    
    // MARK: -  UI Elements
    private lazy var resultLabels: [UILabel] = {
        let labels = [
            createLabel(
                text: "Вы - 🐙!",
                font: .systemFont(ofSize: 50)
            ),
            createLabel(
                text: "Вы осьминог!",
                font: .systemFont(ofSize: 17),
                alignment: .justified,
                lines: 0
            )
        ]
        
        return labels
    }()
    
    private lazy var resultStackView: UIStackView = {
        createStackView(
            subviews: resultLabels
        )
    }()
    
    // MARK: -  Action
    private lazy var doneButtonPressed = UIAction { [ unowned self ] _ in
        dismiss(animated: true)
    }
    
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
        
        updateResult()
    }
    
    func addSubviews() {
        setupSubviews(resultStackView)
    }
    
    func setupSubviews(_ subviews: UIView... ) {
        for subview in subviews {
            view.addSubview(subview)
        }
    }
    
    func updateResult() {
        var frequencyOfAnimals: [Animal: Int] = [:]
        let animals = answers.map { $0.animal }
        
        for animal in animals {
            if let animalTypeCount = frequencyOfAnimals[animal] {
                frequencyOfAnimals.updateValue(animalTypeCount + 1, forKey: animal)
            } else {
                frequencyOfAnimals[animal] = 1
            }
        }
        
        let sortedFrequentOfAnimals = frequencyOfAnimals.max { $0.value < $1.value }
        guard let mostFrequentAnimal = sortedFrequentOfAnimals?.key else { return }
        
        updateUI(with: mostFrequentAnimal)
    }
    
    func updateUI(with animal: Animal) {
        for (index, label) in resultLabels.enumerated() {
            if index == 0 {
                label.text = "Вы - \(animal.rawValue)!"
            } else {
                label.text = animal.definition
            }
        }
    }
    
    func setupNavigationController() {
        title = "Результат"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            systemItem: .done,
            primaryAction: doneButtonPressed
        )
        
        navigationItem.hidesBackButton = true
    }
    
    func createLabel(text: String,
                     font: UIFont,
                     alignment: NSTextAlignment? = nil,
                     lines: Int? = nil) -> UILabel {
        
        let label = UILabel()
        label.text = text
        label.font = font
        label.textAlignment = alignment ?? .left
        label.numberOfLines = lines ?? 1
        
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
