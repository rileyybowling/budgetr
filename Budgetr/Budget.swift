//
//  Budget.swift
//  Budgetr
//
//  Created by Riley Bowling on 4/10/25.
//

import Foundation
import SwiftData

@Model
class Budget {
    var name: String
    var limit: Double
    
    init(name: String, limit: Double) {
        self.name = name
        self.limit = limit
    }
}
