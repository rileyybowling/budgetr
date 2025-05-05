//
//  ExpenseStorage.swift
//  Budgetr
//
//  Created by Riley Bowling on 5/4/25.
//

import Foundation

class ExpenseStorage: ObservableObject {
    @Published var expenses: [Expense] = []
}
