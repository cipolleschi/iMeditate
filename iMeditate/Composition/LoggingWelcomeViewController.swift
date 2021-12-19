//
//  LoggingWelcomeViewController.swift
//  iMeditate
//
//  Created by Riccardo Cipolleschi on 19/12/21.
//

import Foundation
import UIKit

class LoggingWelcomeViewController: WelcomeViewController {
    
    let logger: LogService
    let dateProvider: () -> Date
    
    init(logService: LogService, dateProvider: @escaping () -> Date, nextPressed: @escaping () -> Void) {
        self.logger = logService
        self.dateProvider = dateProvider
        super.init(nextPressed: nextPressed)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.logger.log(event: .init(name: "Before_viewDidLoad", timestamp: dateProvider(), data: [:]))
        super.viewDidLoad()
        self.logger.log(event: .init(name: "After_viewDidLoad", timestamp: dateProvider(), data: [:]))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.logger.log(event: .init(name: "Before_viewDidAppear", timestamp: dateProvider(), data: [:]))
        super.viewDidAppear(animated)
        self.logger.log(event: .init(name: "After_viewDidDisappear", timestamp: dateProvider(), data: [:]))
    }
}
