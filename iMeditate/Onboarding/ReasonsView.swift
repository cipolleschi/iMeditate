//
//  Reasons.swift
//  Environmentally
//
//  Created by Riccardo Cipolleschi on 15/12/21.
//

import UIKit

enum Reason: CaseIterable {
    case relax
    case improveSleep
    case improveAngerManagement
    case handlePanicAttacks
    
    var name: String {
        switch self {
        case .relax:
            return "Relax"
        case .improveSleep:
            return "Sleep"
        case .improveAngerManagement:
            return "Anger Management"
        case .handlePanicAttacks:
            return "Panic Attacks"
        }
    }
}

class ReasonsViewController: UIViewController {
    var nextPressed: (Reason) -> Void
    
    init(nextPressed: @escaping (Reason) -> Void) {
        self.nextPressed = nextPressed
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = ReasonsView(userDidTapNext: nextPressed)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Why Medidate?"
    }
}


class ReasonsView: UIView {
    var userDidTapNext: (Reason) -> Void
    
    let stackView = UIStackView()
    let buttons = Reason.allCases.map { _ in UIButton() }
    
    init(userDidTapNext: @escaping (Reason) -> Void) {
        self.userDidTapNext = userDidTapNext
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
        buttons.forEach { self.stackView.addArrangedSubview($0) }
        
        zip(Reason.allCases, buttons).forEach { reason, button in
            button.addAction(.init { _ in
                self.userDidTapNext(reason)
            }, for: .touchUpInside)
        }
    }
    
    func style() {
        self.backgroundColor = .systemBackground
        self.stackView.axis = .vertical
        self.stackView.spacing = 20
        self.stackView.distribution = .equalCentering
        zip(Reason.allCases, buttons).forEach {
            self.style(button: $1, with: $0.name)
        }
    }
    
    func setupConstraints() {
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.stackView.leadingAnchor.constraint(
                equalTo: self.readableContentGuide.leadingAnchor
            ),
            self.stackView.trailingAnchor.constraint(
                equalTo: self.readableContentGuide.trailingAnchor
            ),
            self.stackView.topAnchor.constraint(equalTo: self.buttons[0].topAnchor),
            self.stackView.bottomAnchor.constraint(
                equalTo: self.buttons[Reason.allCases.count - 1].bottomAnchor),
            self.stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ] + self.buttons.map {
            $0.heightAnchor.constraint(equalToConstant: 50)
        })
    }
}
