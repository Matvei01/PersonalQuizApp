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
    private let questions = Question.getQuestions()
    private var answersChosen: [Answer] = []
    private var currentAnswers: [Answer] {
        questions[questionIndex].answers
    }
    private var questionIndex = 0
    
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
            createButton(title: "Стейк", action: singleAnswerButtonPressed),
            createButton(title: "Рыба", action: singleAnswerButtonPressed),
            createButton(title: "Морковь", action: singleAnswerButtonPressed),
            createButton(title: "Кукуруза", action: singleAnswerButtonPressed)
        ]
        
        return buttons
    }()
    
    private lazy var singleStackView: UIStackView = {
        createStackView(
            subviews: singleButtons
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
        createButton(title: "Ответить", action: multipleAnswerButtonPressed)
    }()
    
    private lazy var multipleStackView: UIStackView = {
        createStackView(subviews: createMultipleSubviews())
    }()
    
    private lazy var rangedSlider: UISlider = {
        let answerCount = Float(currentAnswers.count - 1)
    
        let slider = UISlider()
        slider.maximumValue = answerCount
        slider.value = answerCount / 2
        
        return slider
    }()
    
    private lazy var rangedButton: UIButton = {
        createButton(title: "Ответить", action: rangedAnswerButtonPressed)
    }()
    
    private lazy var rangedLabels: [UILabel] = {
        let labels = [
            createLabel(text: "Ненавижу", font: .systemFont(ofSize: 17)),
            createLabel(text: "Обожаю", font: .systemFont(ofSize: 17), alignment: .right)
        ]
        
        return labels
    }()
    
    private lazy var childRangedStackView: UIStackView = {
        createChildStackView(
            subviews: rangedLabels
        )
    }()
    
    private lazy var rangedStackView: UIStackView = {
        createStackView(
            subviews: [rangedSlider, childRangedStackView, rangedButton]
        )
    }()
    
    // MARK: -  Action
    private lazy var singleAnswerButtonPressed = UIAction { [ unowned self ] action in
        guard let sender = action.sender as? UIButton else { return }
        guard let buttonIndex = singleButtons.firstIndex(of: sender) else { return }
        
        let currentAnswer = currentAnswers[buttonIndex]
        answersChosen.append(currentAnswer)
        
        nextQuestion()
        
    }
    
    private lazy var multipleAnswerButtonPressed = UIAction { [ unowned self ] _ in
        for (multipleSwitch, answer) in zip(multipleSwitches, currentAnswers) {
            if multipleSwitch.isOn {
                answersChosen.append(answer)
            }
        }
        
        nextQuestion()
    }
    
    private lazy var rangedAnswerButtonPressed = UIAction { [ unowned self ] _ in
        let index = lrintf(rangedSlider.value)
        answersChosen.append(currentAnswers[index])
        
        nextQuestion()
    }
    
    
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
        updateUI()
        setupNavigationController()
        setConstraints()
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
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func updateUI() {
        for stackView in [singleStackView, multipleStackView, rangedStackView] {
            stackView.isHidden = true
        }
        
        let currentQuestion = questions[questionIndex]
        
        questionLabel.text = currentQuestion.title
        
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        questionProgressView.setProgress(totalProgress, animated: true)
        
        title = "Вопрос № \(questionIndex + 1) из \(questions.count)"
        
        showCurrentAnswers(for: currentQuestion.responseType)
    }
    
    func showCurrentAnswers(for type: ResponseType) {
        switch type {
        case .single:
            showSingleStackView(with: currentAnswers)
        case .multiple:
            showMultipleStackView(with: currentAnswers)
        case .ranged:
            showRangedStackView(with: currentAnswers)
        }
    }
    
    func showSingleStackView(with answers: [Answer]) {
        singleStackView.isHidden.toggle()
        
        for (button, answer) in zip(singleButtons, answers) {
            button.setTitle(answer.title, for: .normal)
        }
    }
    
    func showMultipleStackView(with answers: [Answer]) {
        multipleStackView.isHidden.toggle()
        
        for (label, answer) in zip(multipleLabels, answers) {
            label.text = answer.title
        }
    }
    
    func showRangedStackView(with answers: [Answer]) {
        rangedStackView.isHidden.toggle()
        
        rangedLabels.first?.text = answers.first?.title
        rangedLabels.last?.text = answers.last?.title
    }
    
    func nextQuestion() {
        questionIndex += 1
        if questionIndex < questions.count {
            updateUI()
            return
        }
        
        let resultVC = ResultViewController()
        resultVC.answers = answersChosen
        navigationController?.pushViewController(resultVC, animated: true)
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
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        return progressView
    }
    
    func createButton(title: String, action: UIAction? = nil) -> UIButton {
        let button = UIButton(type: .system, primaryAction: action)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        
        return button
    }
    
    func createChildStackView(subviews: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: subviews)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        
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
    
    func createMultipleSubviews() -> [UIView] {
        var subviews: [UIView] = []
        for (index, label) in multipleLabels.enumerated() {
            let stackView = UIStackView(arrangedSubviews: [label, multipleSwitches[index]])
            stackView.axis = .horizontal
            stackView.alignment = .fill
            stackView.distribution = .fill
            stackView.spacing = 0
            subviews.append(stackView)
        }
        subviews.append(multipleAnswerButton)
        return subviews
    }
    
    func createSwitch() -> UISwitch {
        let multipleSwitch = UISwitch()
        multipleSwitch.isOn = true
        
        return multipleSwitch
    }
}
//оптимизировать
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

