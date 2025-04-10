//
//  Expense.swift
//  Budgetr
//
//  Created by Riley Bowling on 4/10/25.
//

import Foundation
import SwiftData

@Model
class Expense {
    var category: String
    var amount: Double
    var date: Date
    
    init(category: String, amount: Double, date: Date) {
        self.category =  category
        self.amount = amount
        self.date = date
    }
}
