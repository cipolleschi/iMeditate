//
//  Logging.swift
//  Environmentally
//
//  Created by Riccardo Cipolleschi on 16/12/21.
//

import Foundation
import UIKit

struct Event {
    let name: String
    let timestamp: Date
    let data: [String: String]
}

protocol LogService {
    func log(event: Event)
}

struct ConsoleLogger: LogService {
    func log(event: Event) {
        
        let data = event.data.isEmpty ? ": no data"
            : "\n" + event.data.map { "\($0.key) -> \($0.value)" }.joined(separator: "\n")
        
        print("[\(event.timestamp)] Event: \(event.name) -  Data\(data)")
    }
}

