//
//  ViewController.swift
//  iMeditate
//
//  Created by Riccardo Cipolleschi on 19/12/21.
//

import UIKit

class ViewController: UIViewController {

    let stackView = UIStackView()
    let label = UILabel()
    
    let reason: Reason
    let age: Int
    
    init(reason: Reason, age: Int) {
        self.reason = reason
        self.age = age
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
         fatalError("Not implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        self.styleView()
        self.setupConstraints()
    }
    
    func setupView() {
        self.view.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.label)
    }
    
    func styleView() {
        self.view.backgroundColor = .systemBackground
        
        self.label.text = "You have \(age) years and you choose \(reason.name)"
        self.label.textAlignment = .center
        self.label.numberOfLines = 0
    }
    
    func setupConstraints() {
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.stackView.leadingAnchor.constraint(equalTo: self.view.readableContentGuide.leadingAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.view.readableContentGuide.trailingAnchor),
            self.stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }


}

