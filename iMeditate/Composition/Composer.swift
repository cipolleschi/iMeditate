//
//  Composer.swift
//  iMeditate
//
//  Created by Riccardo Cipolleschi on 19/12/21.
//

import Foundation
import UIKit

struct Composer {
    func onboardingVC(
        logger: LogService,
        dateProvider: @escaping () -> Date,
        callback: @escaping (Reason, Int) -> Void) -> UIViewController
    {
        let nc =  UINavigationController()
        let vc: WelcomeViewController!
        vc = LoggingWelcomeViewController(logService: logger, dateProvider: dateProvider) {
            let reasonVC = ReasonsViewController { reason in
                
                let ageManager = LoggingAgeManagerDecorator(logger: logger, dateProvider: dateProvider, decoratee: LiveAgeManager(age: 25))
                
                let ageViewController = AgeViewController(ageManager: ageManager){ age in
                    logger.log(event: .init(name: "Age_Next_Tapped", timestamp: Date(), data: ["age": "\(age)"]))
                    callback(reason, age)
                }
                
                logger.log(event: .init(name: "Reasons_Next_Tapped", timestamp: Date(), data: ["reason": reason.name]))
                nc.pushViewController(ageViewController, animated: true)
            }
            
            logger.log(event: .init(name: "Welcome_Next_Tapped", timestamp: dateProvider(), data: [:]))
            nc.pushViewController(reasonVC, animated: true)
        }
        
        nc.viewControllers = [vc]
        return nc
    }
}
