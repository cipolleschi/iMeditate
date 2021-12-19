//
//  Welcome.swift
//  Environmentally
//
//  Created by Riccardo Cipolleschi on 15/12/21.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    var nextPressed: () -> Void
    
    init(nextPressed: @escaping () -> Void) {
        self.nextPressed = nextPressed
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view =  WelcomeView(userDidTapNext: nextPressed)
    }
    
}

class WelcomeView: UIView {
    
    let container = UIView()
    let welcomeLabel = UILabel()
    let nextButton = UIButton()
    
    var userDidTapNext: () -> Void
    
    init(userDidTapNext: @escaping () -> Void) {
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
        self.addSubview(self.container)
        self.container.addSubview(self.welcomeLabel)
        self.container.addSubview(self.nextButton)
        
        self.nextButton.addAction(.init { _ in
            self.userDidTapNext()
        }, for: .touchUpInside)
    }
    
    func style() {
        self.backgroundColor = .systemBackground
        self.welcomeLabel.text = "Welcome to iMeditate!"
        self.welcomeLabel.textColor = .black
        self.welcomeLabel.textAlignment = .center
        self.welcomeLabel.font = UIFont.systemFont(ofSize: 36)
        
        self.style(button: self.nextButton, with: "Next")
    }
    
    func setupConstraints() {
        self.prepareAutolayout()
        
        NSLayoutConstraint.activate([
            self.welcomeLabel.topAnchor.constraint(equalTo: self.container.topAnchor),
            self.welcomeLabel.centerXAnchor.constraint(equalTo: self.container.centerXAnchor),
            
            self.nextButton.topAnchor.constraint(
                equalTo: self.welcomeLabel.bottomAnchor,
                constant: 15
            ),
            self.nextButton.centerXAnchor.constraint(equalTo: self.container.centerXAnchor),
            self.nextButton.heightAnchor.constraint(equalToConstant: 50),
            self.nextButton.widthAnchor.constraint(equalTo: self.container.widthAnchor),
            
            self.container.topAnchor.constraint(equalTo: self.welcomeLabel.topAnchor),
            self.container.bottomAnchor.constraint(equalTo: self.nextButton.bottomAnchor),
            self.container.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.container.centerXAnchor.constraint(equalTo: self.readableContentGuide.centerXAnchor),
            self.container.widthAnchor.constraint(equalTo: self.readableContentGuide.widthAnchor)
        
        ])
    }
    
}
