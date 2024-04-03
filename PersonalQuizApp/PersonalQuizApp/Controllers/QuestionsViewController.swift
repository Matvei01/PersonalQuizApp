//
//  QuestionsViewController.swift
//  PersonalQuizApp
//
//  Created by Matvei Khlestov on 02.04.2024.
//

import UIKit

// MARK: -  QuestionsViewController
final class QuestionsViewController: UIViewController {
    
    // MARK: -  Private Properties
    private let first = 0
    private let second = 1
    private let third = 2
    private let fourth = 3
    
    // MARK: -  UI Elements
    private lazy var questionProgressView: UIProgressView = {
        createProgressView()
    }()
    
    private lazy var questionLabel: UILabel = {
        createLabel(
            text: "Какую пищу предпочитаете?",
            font: .systemFont(ofSize: 20),
            autoresizing: false
        )
    }()
    
    private lazy var singleButtons: [UIButton] = {
        let buttons = [
            createButton(title: "Стейк"),
            createButton(title: "Рыба"),
            createButton(title: "Морковь"),
            createButton(title: "Кукуруза")
        ]
        
        return buttons
    }()
    
    private lazy var singleStackView: UIStackView = {
        createStackView(
            subviews: [
                singleButtons[first],
                singleButtons[second],
                singleButtons[third],
                singleButtons[fourth]
            ]
        )
    }()
    
    private lazy var multipleLabels: [UILabel] = {
        let labels = [
            createLabel(text: "Плавать", font: .systemFont(ofSize: 17)),
            createLabel(text: "Спать", font: .systemFont(ofSize: 17)),
            createLabel(text: "Обниматься", font: .systemFont(ofSize: 17)),
            createLabel(text: "Есть", font: .systemFont(ofSize: 17))
        ]
        
        return labels
    }()
    
    private lazy var multipleSwitches: [UISwitch] = {
        let switches = [
            createSwitch(),
            createSwitch(),
            createSwitch(),
            createSwitch()
        ]
        
        return switches
    }()
    
    private lazy var multipleAnswerButton: UIButton = {
        createButton(title: "Ответить")
    }()
    
    private lazy var secondaryMultipleStackViews: [UIStackView] = {
        let stackViews = [
            createSecondaryStackView(
                subviews: [multipleLabels[first], multipleSwitches[first]],
                distribution: .fill, spacing: 0
            ),
            createSecondaryStackView(
                subviews: [multipleLabels[second], multipleSwitches[second]],
                distribution: .fill, spacing: 0
            ),
            createSecondaryStackView(
                subviews: [multipleLabels[third], multipleSwitches[third]],
                distribution: .fill, spacing: 0
            ),
            createSecondaryStackView(
                subviews: [multipleLabels[fourth], multipleSwitches[fourth]],
                distribution: .fill, spacing: 0
            )
        ]
        
        return stackViews
    }()
    
    private lazy var multipleStackView: UIStackView = {
        createStackView(
            subviews: [
                secondaryMultipleStackViews[first],
                secondaryMultipleStackViews[second],
                secondaryMultipleStackViews[third],
                secondaryMultipleStackViews[fourth],
                multipleAnswerButton
            ]
        )
    }()
    
    private lazy var rangedSlider: UISlider = {
        let slider = UISlider()
        slider.value = 0.5
        
        return slider
    }()
    
    private lazy var rangedButton: UIButton = {
        createButton(title: "Ответить")
    }()
    
    private lazy var rangedLabels: [UILabel] = {
        let labels = [
            createLabel(text: "Ненавижу", font: .systemFont(ofSize: 17)),
            createLabel(text: "Обожаю", font: .systemFont(ofSize: 17), alignment: .right)
        ]
        
        return labels
    }()
    
    private lazy var secondaryRangedStackView: UIStackView = {
        createSecondaryStackView(
            subviews: [rangedLabels[first], rangedLabels[second]],
            distribution: .fillEqually,
            spacing: 23
        )
    }()
    
    private lazy var rangedStackView: UIStackView = {
        createStackView(
            subviews: [rangedSlider, secondaryRangedStackView, rangedButton]
        )
    }()
    
    
    // MARK: -  Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: -  Private Methods
private extension QuestionsViewController {
    func setupView() {
        view.backgroundColor = .white
        addSubviews()
        setupNavigationController()
        setConstraints()
        
        singleStackView.isHidden = true
        multipleStackView.isHidden = false
        rangedStackView.isHidden = true
    }
    
    func addSubviews() {
        setupSubviews(
            questionProgressView,
            questionLabel,
            singleStackView,
            multipleStackView,
            rangedStackView
        )
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
    
    func createLabel(text: String,
                     font: UIFont, autoresizing: Bool? = nil,
                     alignment: NSTextAlignment? = nil) -> UILabel {
        
        let label = UILabel()
        label.text = text
        label.font = font
        label.textAlignment = alignment ?? .left
        label.translatesAutoresizingMaskIntoConstraints = autoresizing ?? true
        
        return label
    }
    
    func createProgressView() -> UIProgressView {
        let progressView = UIProgressView()
        progressView.progress = 0.5
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        return progressView
    }
    
    func createButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        
        return button
    }
    
    func createSecondaryStackView(subviews: [UIView],
                                  distribution: UIStackView.Distribution,
                                  spacing: CGFloat) -> UIStackView {
        
        let stackView = UIStackView(arrangedSubviews: subviews)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = distribution
        stackView.spacing = spacing
        
        return stackView
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
    
    func createSwitch() -> UISwitch {
        let multipleSwitch = UISwitch()
        multipleSwitch.isOn = true
        
        return multipleSwitch
    }
}

// MARK: -  Constraints
private extension QuestionsViewController {
    func setConstraints() {
        setConstraintsForProgressView()
        setConstraintsForQuestionLabel()
        setConstraintsForSingleStackView()
        setConstraintsForMultipleStackView()
        setConstraintsForRangedStackView()
    }
    
    func setConstraintsForProgressView() {
        NSLayoutConstraint.activate([
            questionProgressView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0
            ),
            questionProgressView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0
            ),
            questionProgressView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0
            )
        ])
    }
    
    func setConstraintsForQuestionLabel() {
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(
                equalTo: questionProgressView.bottomAnchor,
                constant: 8
            ),
            questionLabel.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 16
            ),
            questionLabel.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -16
            )
        ])
    }
    
    func setConstraintsForSingleStackView() {
        NSLayoutConstraint.activate([
            singleStackView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            singleStackView.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            )
        ])
    }
    
    func setConstraintsForMultipleStackView() {
        NSLayoutConstraint.activate([
            multipleStackView.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            ),
            multipleStackView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 16
            ),
            multipleStackView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -16
            )
        ])
    }
    
    func setConstraintsForRangedStackView() {
        NSLayoutConstraint.activate([
            rangedStackView.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            ),
            rangedStackView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 16
            ),
            rangedStackView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -16
            )
        ])
    }
}

