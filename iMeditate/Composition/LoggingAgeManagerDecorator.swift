//
//  LoggingAgeManagerDecorator.swift
//  iMeditate
//
//  Created by Riccardo Cipolleschi on 19/12/21.
//

import Foundation

class LoggingAgeManagerDecorator: AgeManager {
    var age: Int {
        return self.decoratee.age
    }
    
    var ageDidChange: ((Int) -> Void)? {
        get { self.decoratee.ageDidChange }
        set { self.decoratee.ageDidChange = newValue }
    }
    
    let logger: LogService
    let dateProvider: () -> Date
    var decoratee: AgeManager
    
    init(
        logger: LogService,
        dateProvider: @escaping () -> Date,
        decoratee: AgeManager
    ){
        self.logger = logger
        self.dateProvider = dateProvider
        self.decoratee = decoratee
    }
    
    func increase() {
        let oldValue = self.age
        self.decoratee.increase()
        self.logger.log(event: .init(name: "Age_Increased", timestamp: self.dateProvider(), data: [
            "old_value": "\(oldValue)",
            "new_value": "\(self.age)"
        ]))
    }
    
    func decrease() {
        let oldValue = self.age
        self.decoratee.decrease()
        self.logger.log(event: .init(name: "Age_Increased", timestamp: self.dateProvider(), data: [
            "old_value": "\(oldValue)",
            "new_value": "\(self.age)"
        ]))
    }
}
