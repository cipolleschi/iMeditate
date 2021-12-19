//
//  AgeView.swift
//  Environmentally
//
//  Created by Riccardo Cipolleschi on 15/12/21.
//

import UIKit

protocol AgeManager {
    var age: Int { get }
    var ageDidChange: ((Int) -> Void)? { get set }
    func increase()
    func decrease()
}

class LiveAgeManager: AgeManager {
    var age: Int {
        didSet {
            ageDidChange?(self.age)
        }
    }
    var ageDidChange: ((Int) -> ())?
    
    init(age: Int = 25) {
        self.age = age
    }
    
    func increase() {
        self.age = min(99, self.age + 1)
    }
    
    func decrease() {
        self.age = max(16, self.age - 1)
    }
}

class AgeViewController: UIViewController {
    var ageManager: AgeManager
    var nextPressed: (Int) -> Void
    
    var ageView: AgeView {
        return self.view as! AgeView
    }
    
    init(
        ageManager: AgeManager,
        nextPressed: @escaping (Int) -> Void
    ) {
        self.ageManager = ageManager
        self.nextPressed = nextPressed
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = AgeView(
            age: ageManager.age,
            userDidTapNext: nextPressed,
            userDidTapUpArrow: ageManager.increase,
            userDidTapDownArrow: ageManager.decrease
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "What's Your Age?"
        
        self.ageManager.ageDidChange = { [weak self] newVal in
            self?.ageView.age = newVal
        }
    }
}

class AgeView: UIView {
    
    var userDidTapNext: (Int) -> Void
    var userDidTapUpArrow: () -> ()
    var userDidTapDownArrow: () -> ()
    
    var age: Int {
        didSet {
            self.ageText.text = "\(self.age)"
        }
    }
    
    let stackView = UIStackView()
    let ageText = UILabel()
    let upArrow = UIButton()
    let downArrow = UIButton()
    let nextButton = UIButton()
    
    
    init(
        age: Int,
        userDidTapNext: @escaping (Int) -> Void,
        userDidTapUpArrow: @escaping () -> (),
        userDidTapDownArrow: @escaping () -> ()
    ) {
        self.age = age
        self.userDidTapNext = userDidTapNext
        self.userDidTapUpArrow = userDidTapUpArrow
        self.userDidTapDownArrow = userDidTapDownArrow
        
        super.init(frame: .zero)
        self.setup()
        self.style()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    func setup() {
        self.addSubview(self.stackView)
        
        self.stackView.addArrangedSubview(self.upArrow)
        self.stackView.addArrangedSubview(self.ageText)
        self.stackView.addArrangedSubview(self.downArrow)
        
        self.addSubview(self.nextButton)
        
        self.upArrow.addAction(.init { _ in
            self.userDidTapUpArrow()
        }, for: .touchUpInside)
        
        self.downArrow.addAction(.init { _ in
            self.userDidTapDownArrow()
        }, for: .touchUpInside)
        
        self.nextButton.addAction(.init { _ in
            self.userDidTapNext(self.age)
        }, for: .touchUpInside)
        
    }
    
    func style() {
        self.backgroundColor = .systemBackground
        self.stackView.axis = .vertical
        self.stackView.spacing = 20
        self.stackView.distribution = .equalCentering
        
        self.styleArrow(in: upArrow, title: "▲")
        
        self.ageText.text = "\(self.age)"
        self.ageText.textAlignment = .center
        self.ageText.font = UIFont.systemFont(ofSize: 48, weight: .bold)
        self.ageText.textColor = .black
        
        
        self.styleArrow(in: downArrow, title: "▼")
        self.style(button: self.nextButton, with: "Next")

    }
    
    func styleArrow(in button: UIButton, title: String) {
        var attributedTitle = AttributedString(title)
        attributedTitle.foregroundColor = UIColor.systemGreen
        attributedTitle.font = UIFont.boldSystemFont(ofSize: 56)
        
        var highlightedTitle = attributedTitle
        highlightedTitle.foregroundColor = UIColor.systemGreen.withAlphaComponent(0.5)
        
        button.setAttributedTitle(
            NSAttributedString(highlightedTitle),
            for: .highlighted
        )
        
        button.setAttributedTitle(NSAttributedString(attributedTitle), for: .normal)
        button.setAttributedTitle(NSAttributedString(highlightedTitle), for: .highlighted)
        button.setTitleColor(.systemGreen, for: .normal)
    }
    
    func setupConstraints() {
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.stackView.leadingAnchor.constraint(
                equalTo: self.readableContentGuide.leadingAnchor
            ),
            self.stackView.trailingAnchor.constraint(
                equalTo: self.readableContentGuide.trailingAnchor
            ),
            self.stackView.topAnchor.constraint(equalTo: self.upArrow.topAnchor),
            self.stackView.bottomAnchor.constraint(
                equalTo: self.downArrow.bottomAnchor),
            self.stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            self.nextButton.leadingAnchor.constraint(equalTo: self.readableContentGuide.leadingAnchor),
            self.nextButton.trailingAnchor.constraint(equalTo: self.readableContentGuide.trailingAnchor),
            self.nextButton.heightAnchor.constraint(equalToConstant: 50),
            self.nextButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
