//
//  Budget.swift
//  Budgetr
//
//  Created by Riley Bowling on 4/10/25.
//

import Foundation
import SwiftData

//TODO: change left to remaining

@Model
class Budget {
    var name: String
    var limit: Double
    var left: Double
    
    init(name: String, limit: Double) {
        self.name = name
        self.limit = limit
        self.left = limit
    }
}
