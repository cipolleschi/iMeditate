//
//  Helpers.swift
//  Environmentally
//
//  Created by Riccardo Cipolleschi on 17/12/21.
//

import Foundation
import UIKit

extension UIView {
    func prepareAutolayout() {
        let mirror = Mirror(reflecting: self)
        mirror.children.forEach {
            guard let view = $0.value as? UIView else {
                return
            }
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func style(button: UIButton, with title: String) {
        var attributedTitle = AttributedString(title)
        attributedTitle.foregroundColor = UIColor.white
        attributedTitle.font = UIFont.boldSystemFont(ofSize: 22)
        
        button.setAttributedTitle(
            NSAttributedString(attributedTitle),
            for: .normal
        )
        
        var highlightedTitle = attributedTitle
        highlightedTitle.foregroundColor = UIColor.black.withAlphaComponent(0.5)
        
        button.setAttributedTitle(
            NSAttributedString(highlightedTitle),
            for: .highlighted
        )
        
        button.layer.cornerRadius = 15
        button.backgroundColor = .systemGreen
    }
}
